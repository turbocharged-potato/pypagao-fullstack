# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id          :bigint(8)        not null, primary key
#  content     :string           not null
#  imgur       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint(8)        not null
#  user_id     :bigint(8)        not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:upvotes).conditions(score: 1).class_name('Vote').inverse_of(:answer) }
  it { should have_many(:downvotes).conditions(score: -1).class_name('Vote').inverse_of(:answer) }

  it { should validate_presence_of(:content) }

  it 'has a valid factory' do
    expect(build(:answer)).to be_valid
  end

  describe '#score' do
    it 'works!' do
      answer = create(:answer)
      create_list(:user, 4).each do |user|
        create(:vote, user_id: user.id, answer_id: answer.id, score: 1)
      end
      create_list(:user, 2).each do |user|
        create(:vote, user_id: user.id, answer_id: answer.id, score: -1)
      end
      expect(answer.score).to eq(2)
    end
  end

  describe '#score_of' do
    it 'works!' do
      answer = create(:answer)
      user = create(:user)
      vote = create(:vote, user_id: user.id, answer_id: answer.id)
      expect(answer.score_of(user)).to eq(vote.score)
    end
  end
end
