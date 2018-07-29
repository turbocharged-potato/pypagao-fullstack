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
#  index_papers_on_name_and_semester_id  (name,semester_id) UNIQUE
#  index_papers_on_semester_id           (semester_id)
#
# Foreign Keys
#
#  fk_rails_...  (semester_id => semesters.id)
#

require 'rails_helper'

RSpec.describe Paper, type: :model do
  let!(:paper) { create(:paper) }
  it { should belong_to(:semester) }
  it { should have_many(:questions).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).ignoring_case_sensitivity.scoped_to(:semester_id) }

  it 'has a valid factory' do
    expect(build(:paper)).to be_valid
  end
end
