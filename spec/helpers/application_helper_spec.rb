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

  describe :nl2br do
    context '"test text1.\ntest text2.\n"' do
      subject { nl2br 'test text1.\ntest text2.\n' }
      it { should == 'test text1.<br />test text2.<br />' }
    end
    context '"test text1. test text2."' do
      subject { nl2br 'test text1. test text2.' }
      it { should == 'test text1. test text2.' }
    end
  end

  before(:all) do
    Image = Struct.new :width, :height, :url
    Photo = Struct.new :caption
    @max = Image.new(612, 612, '/images/max.png')
    @mid = Image.new(306, 306, '/images/mid.png')
    @min = Image.new(150, 150, '/images/min.png')
    @photo = Photo.new('test caption')
  end

  describe :sort_images_by_size do
    context '[@max, @mid, @min].shuffle' do
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

  describe :photo_image_tag do
    context '@min, @photo' do
      subject { photo_image_tag @max, @photo }
      it { should be_eql '<img alt="test caption" height="612" src="/images/max.png" title="test caption" width="612" />' }
    end

    context '@mid, @photo' do
      subject { photo_image_tag @mid, @photo }
      it { should be_eql '<img alt="test caption" height="306" src="/images/mid.png" title="test caption" width="306" />' }
    end

    context '@max, @photo' do
      subject { photo_image_tag @min, @photo }
      it { should be_eql '<img alt="test caption" height="150" src="/images/min.png" title="test caption" width="150" />' }
    end
  end

  describe :schema_date do
    subject { schema_date }
    it { should be_eql Time.now.year }
  end

end
