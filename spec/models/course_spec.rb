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

require 'rails_helper'

RSpec.describe Course, type: :model do
  let!(:course) { create(:course) }
  it { should belong_to(:university) }
  it { should have_many(:semesters).dependent(:destroy) }
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:code).ignoring_case_sensitivity }

  it 'has a valid factory' do
    expect(build(:course)).to be_valid
  end
end
