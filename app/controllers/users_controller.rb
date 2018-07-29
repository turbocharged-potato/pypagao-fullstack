# frozen_string_literal: true

class UsersController < ApplicationController
  # /users - lists all users
  def index
    @users = User.all # select(:id, :university_id, :name)
    # @users = if params[:university_id]
    #             users.where(university_id: params[:university_id])
    #        else
    #           users.where(name: params[:name]) if params[:name]
    #        end
  end

  def show
    @user = User.find_by(id: params[:id])
    # user[:votes] = get_score(params[:id])
    # render_json(user, :ok)
  end
end
