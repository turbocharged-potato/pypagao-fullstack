# frozen_string_literal: true

class VotesController < ApplicationController
  def up
    vote = Vote.find_or_create_by(answer_id: params[:answer_id], user_id: current_user.id)
    if vote.score < 1
      vote.score = vote.score + 1
      vote.save
    end
    redirect_to request.referer || answers_path(params[:answer_id])
  end

  def down
    vote = Vote.find_or_create_by(answer_id: params[:answer_id], user_id: current_user.id)
    if vote.score > -1
      vote.score = vote.score - 1
      vote.save
    end
    redirect_to request.referer || answers_path(params[:answer_id])
  end
end
