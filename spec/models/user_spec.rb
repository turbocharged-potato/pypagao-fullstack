# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  university_id          :bigint(8)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_university_id         (university_id)
#
# Foreign Keys
#
#  fk_rails_...  (university_id => universities.id)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:university) }

  it 'should have a valid factory' do
    expect(build(:user)).to be_valid
  end

  it '#karma' do
    user = create(:user)
    answers = create_list(:answer, 5, user: user)
    votes = answers.map { |answer| create(:vote, answer: answer, score: [-1, 0, 1].sample) }
    karma = votes.reduce(0) { |acc, elem| acc + elem.score }

    expect(user.karma).to eq(karma)
  end

  describe '#karma_formatted' do
    it 'works for positive' do
      user = create(:user)
      answers = create_list(:answer, 5, user: user)
      _votes = answers.map { |answer| create(:vote, answer: answer, score: 1) }

      expect(user.karma_formatted).to eq('+5')
    end

    it 'works for negative' do
      user = create(:user)
      answers = create_list(:answer, 5, user: user)
      _votes = answers.map { |answer| create(:vote, answer: answer, score: -1) }

      expect(user.karma_formatted).to eq('-5')
    end

    it 'works for 0' do
      user = create(:user)
      answers = create_list(:answer, 5, user: user)
      _votes = answers.map { |answer| create(:vote, answer: answer, score: 0) }

      expect(user.karma_formatted).to eq('0')
    end
  end
end
