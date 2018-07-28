# frozen_string_literal: true

class CoursesController < ApplicationController
  # /courses - lists all course objects
  def index
    courses_by_university = Course
                            .select(:id, :university_id, :code)
                            .where(university_id: current_user.university_id)
    if params[:code]
      course = courses_by_university.find_by(code: params[:code].upcase)
      redirect_to course_semesters_url course_id: course.id if course
    else
      @courses = courses_by_university
    end
  end

  def show
    courses_by_university = Course
                            .select(:id, :university_id, :code)
                            .where(university_id: current_user.university_id)

    @course = courses_by_university.find_by(id: params[:id])
  end

  def create
    return unless ensure_params_fields([:code])
    course = Course.new course_params
    course.university_id = current_user.university_id
    if course.save
      @course = course.slice(:id, :code)
    else
      render_error(course.errors.full_messages.join(', '), :bad_request)
    end
  end

  private

  def course_params
    params.require(:course).permit(:code)
  end
end
