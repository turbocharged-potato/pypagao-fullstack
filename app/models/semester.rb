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
#  index_semesters_on_course_id  (course_id)
#  unique_constraint_thingy      (start_year,end_year,number,course_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#

class Semester < ApplicationRecord
  default_scope { order(start_year: :desc, number: :desc) }

  belongs_to :course
  has_many :papers, dependent: :destroy

  validates :number, presence: true, inclusion: { in: [1, 2] }
  validates :start_year, presence: true, numericality: { greater_than: 0 },
                         uniqueness: { scope: %i[end_year number course_id] }
  validates :end_year, presence: true, numericality: { greater_than: 0 }
  validate :start_year_right_before_end_year

  def start_year_right_before_end_year
    errors.add(:end_year, 'must be right after start year') unless
      end_year && start_year && end_year - start_year == 1
  end

  def formatted
    "#{start_year}/#{end_year} Semester #{number}"
  end
end
