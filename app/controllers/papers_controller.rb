# frozen_string_literal: true

class PapersController < ApplicationController
  # /semesters/1/paper - lists papers
  def index
    return unless ensure_params_fields([:semester_id])
    @semester = Semester.find_by(id: params[:semester_id])
    @course = @semester.course
    @papers = Paper.all
  end
end
