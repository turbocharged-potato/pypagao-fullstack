# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    it 'without params[:code]' do
      user = create(:user)
      sign_in user
      university = create(:university)
      get :index, params: { university_id: university.id }
      should respond_with :ok
    end

    it 'with params[:code] and found' do
      user = create(:user)
      sign_in user
      university = create(:university)
      course = create(:course, university: university, code: 'anu')
      get :index, params: { university_id: university.id, code: 'anu' }
      should redirect_to course_semesters_url(course.id)
    end

    it 'with params[:code] and not found' do
      user = create(:user)
      sign_in user
      university = create(:university)
      get :index, params: { university_id: university.id, code: 'anu' }
      should redirect_to university_courses_url(university.id)
      expect(flash[:alert]).to eq('Course not found. Maybe create a new course?')
    end
  end

  describe 'POST #create' do
    it 'succeeds' do
      user = create(:user)
      sign_in user
      university = create(:university)
      expect do
        post :create, params: { university_id: university.id,
                                course: { code: 'JAV101', university_id: university.id } }
      end.to change(Course, :count).by(1)
      should redirect_to course_semesters_url(Course.find_by(university_id: university.id,
                                                             code: 'JAV101').id)
      expect(flash[:notice]).to eq('New course created')
    end

    it 'does stuffs when failed saving' do
      sign_in create(:user)
      university = create(:university)
      course = build(:course, university: university)
      allow(Course).to receive(:new).and_return(course)
      allow(course).to receive(:save).and_return(false)
      post :create, params: { university_id: university.id,
                              course: { code: course.code, university_id: university.id } }
      should redirect_to university_courses_url(university.id)
      expect(flash[:alert]).to start_with('Failed to save course.')
    end
  end
end
