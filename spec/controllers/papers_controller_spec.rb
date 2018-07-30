# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PapersController, type: :controller do
  describe 'GET #index' do
    it do
      sign_in create(:user)
      paper = create(:paper)
      get :index, params: { semester_id: paper.semester.id }
      should respond_with :ok
    end
  end

  describe 'POST #create' do
    it 'succeeds' do
      sign_in create(:user)
      semester = create(:semester)
      paper = build(:paper, semester: semester)
      expect do
        post :create, params: { semester_id: semester.id, paper: { name: paper.name } }
      end.to change(Paper, :count).by(1)
      should redirect_to semester_papers_url(semester.id)
      expect(flash[:notice]).to start_with('New paper created under')
    end

    it 'does stuffs when failed saving' do
      sign_in create(:user)
      semester = create(:semester)
      paper = build(:paper, semester: semester)
      allow(Paper).to receive(:new).and_return(paper)
      allow(paper).to receive(:save).and_return(false)
      post :create, params: { semester_id: semester.id, paper: { name: paper.name } }
      should redirect_to semester_papers_url(semester.id)
      expect(flash[:alert]).to start_with('Failed to create paper.')
    end
  end
end
