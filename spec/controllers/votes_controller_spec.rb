# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  describe 'POST #up' do
    it 'does nothing when score is 1' do
      user = create(:user)
      sign_in user
      answer = create(:answer)
      vote = create(:vote, answer: answer, user: user, score: 1)
      post :up, params: { answer_id: answer.id }
      expect(Vote.find(vote.id).score).to eq(1)
    end

    it 'increases when score < 1' do
      user = create(:user)
      sign_in user
      answer = create(:answer)
      vote = create(:vote, answer: answer, user: user, score: [-1, 0].sample)
      post :up, params: { answer_id: answer.id }
      expect(Vote.find(vote.id).score).to eq(vote.score + 1)
    end

    it 'creates vote when it doesn\'t exist' do
      user = create(:user)
      sign_in user
      answer = create(:answer)
      post :up, params: { answer_id: answer.id }
      expect(Vote.find_by(user_id: user.id, answer_id: answer.id).score).to eq(1)
    end
  end

  describe 'POST #down' do
    it 'does nothing when score is -1' do
      user = create(:user)
      sign_in user
      answer = create(:answer)
      vote = create(:vote, answer: answer, user: user, score: -1)
      post :down, params: { answer_id: answer.id }
      expect(Vote.find(vote.id).score).to eq(-1)
    end

    it 'decreases when score > -1' do
      user = create(:user)
      sign_in user
      answer = create(:answer)
      vote = create(:vote, answer: answer, user: user, score: [0, 1].sample)
      post :down, params: { answer_id: answer.id }
      expect(Vote.find(vote.id).score).to eq(vote.score - 1)
    end

    it 'creates vote when it doesn\t exist' do
      user = create(:user)
      sign_in user
      answer = create(:answer)
      post :down, params: { answer_id: answer.id }
      expect(Vote.find_by(user_id: user.id, answer_id: answer.id).score).to eq(-1)
    end
  end
end
