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

require 'rails_helper'

RSpec.describe Semester, type: :model do
  let!(:semester) { create(:semester) }
  it { should belong_to(:course) }
  it { should have_many(:papers).dependent(:destroy) }
  it { should validate_presence_of(:number) }
  it { should validate_inclusion_of(:number).in_array([1, 2]) }
  it { should validate_presence_of(:start_year) }
  it do
    should validate_uniqueness_of(:start_year)
      .scoped_to(%i[end_year number course_id])
      .ignoring_case_sensitivity
  end
  it { should validate_numericality_of(:start_year).is_greater_than(0) }
  it { should validate_presence_of(:end_year) }
  it { should validate_numericality_of(:end_year).is_greater_than(0) }

  it 'accepts start year right after end year' do
    expect(build(:semester, start_year: 2000, end_year: 2001)).to be_valid
  end

  it 'rejects start year not right after end year' do
    expect(build(:semester, start_year: 2000, end_year: 2000)).to_not be_valid
    expect(build(:semester, start_year: 2000, end_year: 2002)).to_not be_valid
  end

  it 'has a valid factory' do
    expect(build(:semester)).to be_valid
  end

  describe '#formatted' do
    it 'formats correctly ' do
      semester = build(:semester, start_year: 2018, end_year: 2019, number: 1)
      expect(semester.formatted).to eq('2018/2019 Semester 1')
    end
  end
end
