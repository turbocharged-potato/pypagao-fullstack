# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paper_id   :bigint(8)        not null
#
# Indexes
#
#  index_questions_on_number    (number) UNIQUE
#  index_questions_on_paper_id  (paper_id)
#
# Foreign Keys
#
#  fk_rails_...  (paper_id => papers.id)
#

FactoryBot.define do
  factory :question do
    sequence(:name) { |n| "Question no #{n}" }
    sequence(:number)
    paper
  end
end
