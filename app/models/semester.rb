# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id         :bigint(8)        not null, primary key
#  end_year   :integer
#  number     :integer
#  start_year :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint(8)
#
# Indexes
#
#  index_semesters_on_course_id                           (course_id)
#  index_semesters_on_start_year_and_end_year_and_number  (start_year,end_year,number)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#

class Semester < ApplicationRecord
  belongs_to :course
end
