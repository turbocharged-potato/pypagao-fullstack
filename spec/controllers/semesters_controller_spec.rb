# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SemestersController, type: :controller do
  describe 'GET #index' do
    it do
      sign_in create(:user)
      semester = create(:semester)
      get :index, params: { course_id: semester.course.id }
      should respond_with :ok
    end
  end

  describe 'POST #create' do
    it 'succeeds' do
      sign_in create(:user)
      course = create(:course)
      semester = build(:semester, course: course)
      expect do
        post :create, params: { course_id: course.id, semester: { start_year: semester.start_year,
                                                                  end_year: semester.end_year,
                                                                  number: semester.number } }
      end.to change(Semester, :count).by(1)
      should redirect_to course_semesters_url(course.id)
      expect(flash[:notice]).to eq("New semester created under #{course.code}")
    end

    it 'does stuffs when failed saving' do
      sign_in create(:user)
      course = create(:course)
      semester = build(:semester, course: course)
      allow(Semester).to receive(:new).and_return(course)
      allow(course).to receive(:save).and_return(false)
      post :create, params: { course_id: course.id, semester: { start_year: semester.start_year,
                                                                end_year: semester.end_year,
                                                                number: semester.number }
      should redirect_to course_semesters_url(course.id)
      expect(flash[:alert]).to start_with('Failed to create semester.')
    end
  end
end
