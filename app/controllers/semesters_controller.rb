# frozen_string_literal: true

class SemestersController < ApplicationController
  # /courses/1/semester - lists semester
  def index
    @course = Course.find(params[:course_id])
    @semester = Semester.new
  end

  def create
    semester = Semester.new semester_params
    if semester.save
      redirect_to course_semesters_url(semester.course.id),
                  notice: "New semester created under #{semester.course.code}"
    else
      redirect_to course_semesters_url(semester.course.id),
                  alert: "Failed to create semester. #{semester.errors.full_messages.join(', ')}"
    end
  end

  private

  def semester_params
    params.require(:semester).permit(:start_year,
                                     :end_year,
                                     :number,
                                     :course_id)
  end
end
