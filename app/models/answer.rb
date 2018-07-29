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

class Answer < ApplicationRecord
  default_scope { eager_load(:upvotes, :downvotes, :comments, :user) }

  belongs_to :question
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  has_many :upvotes, -> { where score: 1 }, class_name: 'Vote', inverse_of: :answer
  has_many :downvotes, -> { where score: -1 }, class_name: 'Vote', inverse_of: :answer

  validates :content, presence: true

  def score
    upvotes.size - downvotes.size
  end

  def score_of(user)
    Vote.find_by(answer_id: id, user_id: user.id)&.score || 0
  end
end
