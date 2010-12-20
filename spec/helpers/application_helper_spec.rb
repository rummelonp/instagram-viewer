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

  describe 'sort_images_by_size' do
    context '[@max, @mid, @min].shuffle' do
      before(:all) do
        Image = Struct.new :width, :height
        @max = Image.new(100, 100)
        @mid = Image.new(50, 50)
        @min = Image.new(10, 10)
      end
      before do
        @unsort_images = [@max, @mid, @min].shuffle
        @sorted_images = sort_images_by_size @unsort_images
      end
      it 'first should @min' do
        @sorted_images.first.should == @min
      end
      it 'at 1 should @mid' do
        @sorted_images.at(1).should == @mid
      end
      it 'last should @max' do
        @sorted_images.last.should == @max
      end
    end
  end

end
