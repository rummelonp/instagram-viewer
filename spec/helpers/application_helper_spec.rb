require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ApplicationHelper do

  describe 'nl2br "test text1.\ntest text2.\n"' do
    subject { nl2br 'test text1.\ntest text2.\n' }
    it { should == 'test text1.<br />test text2.<br />' }
  end

end
