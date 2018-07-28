# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id         :bigint(8)        not null, primary key
#  end_year   :integer          not null
#  number     :integer          not null
#  start_year :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint(8)        not null
#
# Indexes
#
#  index_semesters_on_course_id                           (course_id)
#  index_semesters_on_start_year_and_end_year_and_number  (start_year,end_year,number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#

FactoryBot.define do
  factory :semester do
    sequence(:start_year, 2000)
    sequence(:end_year, 2001)
    number 1
    course
  end
end
