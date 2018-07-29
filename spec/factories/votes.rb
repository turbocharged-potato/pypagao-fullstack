# frozen_string_literal: true

# == Schema Information
#
# Table name: votes
#
#  id         :bigint(8)        not null, primary key
#  score      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  answer_id  :bigint(8)        not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_votes_on_answer_id              (answer_id)
#  index_votes_on_answer_id_and_user_id  (answer_id,user_id) UNIQUE
#  index_votes_on_score                  (score) USING hash
#  index_votes_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (answer_id => answers.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :vote do
    answer
    user
    score [-1, 0, 1].sample
  end
end
