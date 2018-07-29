# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    @questions = Question.eager_load(answers: %i[user upvotes downvotes comments],
                                     paper: { semester: :course })
                         .where(paper_id: params[:paper_id])
    @question = Question.new
  end
end
