# frozen_string_literal: true

class AnswersController < ApplicationController
  def index
    @question = Question.eager_load(paper: { semester: :course }).find(params[:question_id])
    @answers = Answer.where(question_id: params[:question_id]).sort { |a, b| b.score <=> a.score }
    @current_user = current_user
  end
end
