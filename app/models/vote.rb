# frozen_string_literal: true

# == Schema Information
#
# Table name: votes
#
#  id         :bigint(8)        not null, primary key
#  score      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  answer_id  :bigint(8)        not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_votes_on_answer_id  (answer_id)
#  index_votes_on_score      (score) USING hash
#  index_votes_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (answer_id => answers.id)
#  fk_rails_...  (user_id => users.id)
#

class Vote < ApplicationRecord
  belongs_to :answer
  belongs_to :user

  validates :score, presence: true, inclusion: { in: [-1, 0, 1] }
end
