# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paper_id   :bigint(8)        not null
#
# Indexes
#
#  index_questions_on_name      (name) UNIQUE
#  index_questions_on_paper_id  (paper_id)
#
# Foreign Keys
#
#  fk_rails_...  (paper_id => papers.id)
#

class Question < ApplicationRecord
  belongs_to :paper
  has_many :answers, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
