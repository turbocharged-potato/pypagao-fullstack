# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CoursesHelper. For example:
#
# describe CoursesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#flash_class' do
    it 'returns correctly alert-success' do
      expect(helper.flash_class(:notice)).to eq('alert alert-success alert-dismissible')
      expect(helper.flash_class(:alert)).to eq('alert alert-danger alert-dismissible')
    end
  end
end
