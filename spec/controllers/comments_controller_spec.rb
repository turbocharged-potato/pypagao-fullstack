# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'GET #index' do
    it do
      user = create(:user)
      sign_in user
      comment = create(:comment, user: user)
      get :index, params: { answer_id: comment.answer.id }
      should respond_with :ok
    end
  end

  describe 'POST #create' do
    it 'succeeds' do
      user = create(:user)
      answer = create(:answer)
      sign_in user
      comment = build(:comment, user: user)
      expect do
        post :create, params: { answer_id: answer.id, comment: { content: comment.content } }
      end.to change(Comment, :count).by(1)
      should redirect_to answer_comments_path(answer.id)
      expect(flash[:notice]).to eq('New comment published')
    end

    it 'does stuffs when failed saving' do
      user = create(:user)
      answer = create(:answer)
      sign_in user
      comment = build(:comment, user: user)
      allow(Comment).to receive(:new).and_return(comment)
      allow(comment).to receive(:save).and_return(false)
      post :create, params: { answer_id: answer.id, comment: { content: comment.content } }
      should redirect_to answer_comments_path(answer.id)
      expect(flash[:alert]).to start_with('Failed to publish new comment: ')
    end
  end

  describe 'POST #update' do
    it 'succeeds' do
      user = create(:user)
      sign_in user
      comment = create(:comment, user: user, content: '123')
      post :update, params: { id: comment.id, comment: { content: '456' } }
      expect(Comment.find(comment.id).content).to eq('456')
      should redirect_to answer_comments_path(comment.answer.id)
      expect(flash[:notice]).to eq('Comment successfully updated')
    end

    it 'rejects unauthorised user' do
      sign_in create(:user)
      comment = create(:comment, content: '123')
      post :update, params: { id: comment.id, comment: { content: '456' } }
      expect(Comment.find(comment.id).content).to eq('123')
      should redirect_to answer_comments_path(comment.answer.id)
      expect(flash[:alert]).to eq('Unauthorised to edit/delete comment')
    end

    it 'does stuffs when failed saving' do
      user = create(:user)
      sign_in user
      comment = create(:comment, user: user, content: '123')
      allow(Comment).to receive(:find).and_return(comment)
      allow(comment).to receive(:update).and_return(false)
      post :update, params: { id: comment.id, comment: { content: '456' } }
      should redirect_to answer_comments_path(comment.answer.id)
      expect(flash[:alert]).to eq('Failed to update comment: ')
    end
  end

  describe 'DELETE #destroy' do
    it 'succeeds' do
      user = create(:user)
      sign_in user
      comment = create(:comment, user: user)
      expect do
        delete :destroy, params: { id: comment.id }
      end.to change(Comment, :count).by(-1)
      should redirect_to answer_comments_path(comment.answer.id)
    end

    it 'rejects unauthorised user' do
      sign_in create(:user)
      comment = create(:comment)
      expect do
        delete :destroy, params: { id: comment.id }
      end.to_not change(Comment, :count)
      should redirect_to answer_comments_path(comment.answer.id)
      expect(flash[:alert]).to eq('Unauthorised to edit/delete comment')
    end
  end
end
