# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #index' do
    it do
      user = create(:user)
      answer = create(:answer, user: user)
      sign_in user
      get :index, params: { question_id: answer.question.id }
      should respond_with :ok
    end
  end

  describe 'POST #create' do
    it 'succeeds' do
      user = create(:user)
      question = create(:question)
      sign_in user
      answer = build(:answer, user: user, question: question)
      expect do
        post :create, params: { question_id: question.id, answer: { content: answer.content } }
      end.to change(Answer, :count).by 1
      should redirect_to question_answers_path(question.id)
      expect(flash[:notice]).to eq('New answer successfully created')
    end

    it 'does stuffs when failed saving' do
      user = create(:user)
      question = create(:question)
      sign_in user
      answer = build(:answer, user: user, question: question)
      allow(Answer).to receive(:new).and_return(answer)
      allow(answer).to receive(:save).and_return(false)
      post :create, params: { question_id: question.id, answer: { content: answer.content } }
      should redirect_to question_answers_path(question.id)
      expect(flash[:alert]).to start_with('Failed to create new answer: ')
    end
  end

  describe 'POST #update' do
    it 'succeeds' do
      user = create(:user)
      sign_in user
      answer = create(:answer, user: user, content: '123')
      post :update, params: { id: answer.id, answer: { content: '456' } }
      expect(Answer.find(answer.id).content).to eq('456')
      should redirect_to question_answers_path(answer.question.id)
      expect(flash[:notice]).to eq('Answer successfully updated')
    end

    it 'rejects unauthorised user' do
      user = create(:user)
      sign_in user
      answer = create(:answer, content: '123')
      post :update, params: { id: answer.id, answer: { content: '456' } }
      expect(Answer.find(answer.id).content).to eq('123')
      should redirect_to question_answers_path(answer.question.id)
      expect(flash[:alert]).to start_with('Unauthorised to edit/delete answer')
    end

    it 'does stuffs when failed updating' do
      user = create(:user)
      sign_in user
      answer = create(:answer, user: user, content: '123')
      allow(Answer).to receive(:find).and_return(answer)
      allow(answer).to receive(:update).and_return(false)
      post :update, params: { id: answer.id, answer: { content: '456' } }
      should redirect_to question_answers_path(answer.question.id)
      expect(flash[:alert]).to start_with('Failed to update answer')
    end
  end

  describe 'DELETE #destroy' do
    it 'succeeds' do
      user = create(:user)
      sign_in user
      answer = create(:answer, user: user)
      expect do
        delete :destroy, params: { id: answer.id }
      end.to change(Answer, :count).by(-1)
      should redirect_to question_answers_path(answer.question.id)
    end

    it 'rejects unauthorised user' do
      sign_in create(:user)
      answer = create(:answer)
      expect do
        delete :destroy, params: { id: answer.id }
      end.to_not change(Answer, :count)
      should redirect_to question_answers_path(answer.question.id)
      expect(flash[:alert]).to start_with('Unauthorised to edit/delete answer')
    end
  end
end
