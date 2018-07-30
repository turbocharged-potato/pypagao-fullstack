# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    it do
      sign_in create(:user)
      question = create(:question)
      get :index, params: { paper_id: question.paper.id }
      should respond_with :ok
    end
  end

  describe 'POST #create' do
    it 'succeeds' do
      sign_in create(:user)
      paper = create(:paper)
      question = build(:question, paper: paper)
      expect do
        post :create, params: { paper_id: paper.id, question: { name: question.name,
                                                                number: question.number } }
      end.to change(Question, :count).by(1)
      should redirect_to paper_questions_path(paper.id)
      expect(flash[:notice]).to eq('New question successfully created.')
    end

    it 'does stuffs when failed saving' do
      sign_in create(:user)
      paper = create(:paper)
      question = build(:question, paper: paper)
      allow(Question).to receive(:new).and_return(question)
      allow(question).to receive(:save).and_return(false)
      post :create, params: { paper_id: paper.id, question: { name: question.name,
                                                              number: question.number } }
      should redirect_to paper_questions_path(paper.id)
      expect(flash[:alert]).to start_with('Failed to create new question: ')
    end
  end
end
