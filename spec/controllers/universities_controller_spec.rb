# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UniversitiesController, type: :controller do
  describe 'GET #index' do
    before do
      sign_in create(:user)
      get :index
    end
    it { should respond_with :ok }
  end

  describe 'POST #create' do
    it 'succeeds' do
      sign_in create(:user)
      expect do
        post :create, params: { university: { name: 'SMRT' } }
      end.to change(University, :count).by(1)
      expect(flash[:notice]).to eq('New university created')
      should redirect_to university_courses_url(University.find_by(name: 'SMRT').id)
    end

    it 'does stuffs when failed saving' do
      sign_in create(:user)
      university = build(:university)
      allow(University).to receive(:new).and_return(university)
      allow(university).to receive(:save).and_return(false)
      post :create, params: { university: { name: university.name } }
      should redirect_to universities_url
      expect(flash[:alert]).to start_with('Failed to save university.')
    end
  end
end
