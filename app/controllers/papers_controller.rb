# frozen_string_literal: true

class PapersController < ApplicationController
  # /semesters/1/paper - lists papers
  def index
    return unless ensure_params_fields([:semester_id])
    @semester = Semester.find_by(id: params[:semester_id])
    @course = @semester.course
    @papers = @semester.papers
    @paper = Paper.new
  end

  def create
    paper = Paper.new paper_params
    if paper.save
      redirect_to semester_papers_url(paper.semester.course.id),
                  notice: "New paper created under #{paper.semester.course.code} #{paper.semester.start_year}/ #{paper.semester.start_year} Sem #{paper.semester.number} "
    else
      redirect_to semester_papers_url(paper.semester.course.id),
                  alert: "Failed to create paper. #{paper.errors.full_messages.join(', ')}"
    end
  end

  private

  def paper_params
    params.require(:paper).permit(:name, :semester_id)
  end
end
