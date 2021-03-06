# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id            :bigint(8)        not null, primary key
#  code          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  university_id :bigint(8)        not null
#
# Indexes
#
#  index_courses_on_code           (code) UNIQUE
#  index_courses_on_university_id  (university_id)
#
# Foreign Keys
#
#  fk_rails_...  (university_id => universities.id)
#

FactoryBot.define do
  factory :course do
    sequence(:code) { |n| "CS110#{n}" }
    university
  end
end
