# frozen_string_literal: true

class AnswersController < ApplicationController
  def index
    @question = Question.eager_load(paper: { semester: :course }).find(params[:question_id])
    @answers = Answer.where(question_id: params[:question_id]).sort { |a, b| b.score <=> a.score }
    @current_user = current_user

    @answer = Answer.new
  end

  def create
    answer = Answer.new create_answer_params
    if answer.save
      redirect_back_or_to question_answers_path(params[:question_id]),
                          notice: 'New answer successfully created'
    else
      redirect_back_or_to question_answers_path(params[:question_id]),
                          alert: 'Failed to create new answer: ' +
                                 answer.errors.full_messages.join(', ')
    end
  end

  def update
    answer = Answer.find(params[:id])
    return unless ensure_authorised(answer)
    question_id = answer.question.id
    if answer.update(answer_params)
      redirect_back_or_to question_answers_path(question_id),
                          notice: 'Answer successfully updated'
    else
      redirect_back_or_to question_answers_path(question_id),
                          alert: 'Failed to update answer:' + answer.errors.full_messages.join(', ')
    end
  end

  def destroy
    answer = Answer.find(params[:id])
    return unless ensure_authorised(answer)
    question_id = answer.question.id
    redirect_back_or_to question_answers_path(question_id) if answer.destroy
  end

  private

  def ensure_authorised(answer)
    if answer.user.id != current_user.id
      redirect_back_or_to question_answers_path(answer.question.id),
                          alert: 'Unauthorised to edit/delete answer'
      return false
    end
    true
  end

  def create_answer_params
    answer_params.merge(user_id: current_user.id, question_id: params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content)
  end
end
