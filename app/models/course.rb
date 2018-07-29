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

class Course < ApplicationRecord
  belongs_to :university
  has_many :semesters, dependent: :destroy
  validates :code, presence: true, uniqueness: { case_sensitive: false }

  before_save :upcase_code

  def upcase_code
    code.upcase!
  end
end
