# frozen_string_literal: true

class PapersController < ApplicationController
  # /semesters/1/paper - lists papers
  def index
    @semester = Semester.eager_load(:papers).find(params[:semester_id])
    @paper = Paper.new
  end

  def create
    paper = Paper.new paper_params
    if paper.save
      redirect_to semester_papers_url(paper.semester.id),
                  notice: new_paper_notice(paper)
    else
      redirect_to semester_papers_url(paper.semester.id),
                  alert: "Failed to create paper. #{paper.errors.full_messages.join(', ')}"
    end
  end

  private

  def new_paper_notice(paper)
    "New paper created under #{paper.semester.course.code}
                             #{paper.semester.start_year}/ #{paper.semester.start_year}
                             Sem #{paper.semester.number} "
  end

  def paper_params
    params.require(:paper).permit(:name, :semester_id)
  end
end
