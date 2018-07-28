# frozen_string_literal: true

# == Schema Information
#
# Table name: papers
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  semester_id :bigint(8)        not null
#
# Indexes
#
#  index_papers_on_name         (name) UNIQUE
#  index_papers_on_semester_id  (semester_id)
#
# Foreign Keys
#
#  fk_rails_...  (semester_id => semesters.id)
#

FactoryBot.define do
  factory :paper do
    sequence(:name) { |n| "Finals#{n}" }
    semester
  end
end
