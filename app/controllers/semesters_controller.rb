# frozen_string_literal: true

class SemestersController < ApplicationController
  # /courses/1/semester - lists semester
  def index
    return unless ensure_params_fields([:course_id])
    @course = Course.find_by(id: params[:course_id])
    @semesters = Semester.all
  end
end
