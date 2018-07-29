# frozen_string_literal: true

class CoursesController < ApplicationController
  # /courses - lists all course objects
  def index
    @course = Course.new
    @university = University.find(params[:university_id])
    courses_by_university = Course
                            .select(:id, :university_id, :code)
                            .where(university_id: params[:university_id])
    course = courses_by_university.find_by(code: params[:code].upcase) if params[:code]
    redirection(course, @university) if params[:code]
  end

  def create
    course = Course.new course_params
    if course.save
      redirect_to course_semesters_url(course.id), notice: 'New course created'
    else
      redirect_to university_courses_url(course.university_id), alert: "Failed to save course.
                                                  #{course.errors.full_messages.join(', ')}"
    end
  end

  private

  def redirection(course, university)
    if course
      redirect_to course_semesters_url(course.id)
    else
      redirect_to university_courses_url(university.id),
                  alert: 'Course not found. Maybe create a new course?'
    end
  end

  def course_params
    params.require(:course).permit(:code, :university_id)
  end
end
