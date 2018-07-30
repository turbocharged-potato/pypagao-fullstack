# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    before do
      sign_in create(:user)
      get :index
    end
    it { should respond_with :ok }
  end

  describe 'GET #show' do
    it do
      user = create(:user)
      sign_in user
      get :show, params: { id: user.id }
      should respond_with :ok
    end
  end
end
