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

class Paper < ApplicationRecord
  belongs_to :semester
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
