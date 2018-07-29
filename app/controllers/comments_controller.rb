# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @answer = Answer.find(params[:answer_id])
    @comments = Comment.where(answer_id: params[:answer_id])
    @current_user = current_user

    @comment = Comment.new
  end

  def create
    comment = Comment.new create_comment_params
    if comment.save
      redirect_back_or_to answer_comments_path(params[:answer_id]),
                          notice: 'New comment published'
    else
      redirect_back_or_to answer_comments_path(params[:answer_id]),
                          alert: 'Failed to publish new comment: ' +
                                 comment.errors.full_messages.join(', ')
    end
  end

  def update
    comment = Comment.find(params[:id])
    answer_id = comment.answer.id
    if comment.update comment_params
      redirect_back_or_to answer_comments_path(answer_id),
                          notice: 'Comment successfully updated'
    else
      redirect_back_or_to answer_comments_path(answer_id),
                          alert: 'Failed to update comment: ' +
                                 comment.errors.full_messages.join(', ')
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    answer_id = comment.answer.id
    redirect_back_or_to answer_comments_path(answer_id) if comment.destroy
  end

  private

  def create_comment_params
    comment_params.merge(user_id: current_user.id, answer_id: params[:answer_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
