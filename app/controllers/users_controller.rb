# frozen_string_literal: true

class UsersController < ApplicationController
  # /users - lists all users
  def index
    @users = User.eager_load(:university).all.sort { |a, b| b.karma <=> a.karma }.take(100)
  end

  def show
    @user = User.find(params[:id])
    @answers = Answer.where(user_id: @user.id).order(:created_at).limit(20)
  end
end
