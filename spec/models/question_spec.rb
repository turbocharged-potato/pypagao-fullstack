# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paper_id   :bigint(8)        not null
#
# Indexes
#
#  index_questions_on_number_and_paper_id  (number,paper_id) UNIQUE
#  index_questions_on_paper_id             (paper_id)
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
  it { should validate_presence_of(:number) }
  it { should validate_uniqueness_of(:number).scoped_to(:paper_id) }
  it { should validate_numericality_of(:number).is_greater_than(0) }

  it 'has a valid factory' do
    expect(build(:question)).to be_valid
  end
end
