# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    @questions = Question.eager_load(answers: %i[user upvotes downvotes comments],
                                     paper: { semester: :course })
                         .where(paper_id: params[:paper_id])
    @question = Question.new
    @paper = Paper.find(params[:paper_id])
  end

  def create
    question = Question.new question_params
    if question.save
      redirect_back_or_to paper_questions_path(params[:paper_id]),
                          notice: 'New question successfully created.'
    else
      redirect_back_or_to paper_questions_path(params[:paper_id]),
                          alert: 'Failed to create new question: ' +
                                 question.errors.full_messages.join(', ')
    end
  end

  private

  def question_params
    params.require(:question).permit(:name, :number).merge(paper_id: params[:paper_id])
  end
end
