# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paper_id   :bigint(8)        not null
#
# Indexes
#
#  index_questions_on_name      (name) UNIQUE
#  index_questions_on_paper_id  (paper_id)
#
# Foreign Keys
#
#  fk_rails_...  (paper_id => papers.id)
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:question) { create(:question) }
  it { should belong_to(:paper) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }

  it 'has a valid factory' do
    expect(build(:question)).to be_valid
  end
end
