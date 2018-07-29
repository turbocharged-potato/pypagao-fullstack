# frozen_string_literal: true

class CoursesController < ApplicationController
  # /courses - lists all course objects
  def index
    @course = Course.new
    courses_by_university = Course
                            .select(:id, :university_id, :code)
                            .where(university_id: current_user.university_id)
    if params[:code]
      course = courses_by_university.find_by(code: params[:code].upcase)
      redirection(course)
    end
  end

  def show
    courses_by_university = Course
                            .select(:id, :university_id, :code)
                            .where(university_id: current_user.university_id)

    @course = courses_by_university.find_by(id: params[:id])
  end

  def create
    course = Course.new course_params
    course.code.upcase!
    course.university_id = current_user.university_id
    if course.save
      redirect_to course_semesters_url(course.id), notice: 'New course created'
    else
      redirect_to courses_url, alert: 'Failed to save course. Course already exists.'
    end
  end

  private

  def redirection(course)
    if course
      redirect_to course_semesters_url(course.id)
    else
      redirect_to courses_path, alert: 'Course not found. Maybe create a new course?'
    end
  end

  def course_params
    params.require(:course).permit(:code)
  end
end
