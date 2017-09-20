require 'spec_helper'

RSpec.describe BitmapEditor do

  describe '#new_bitmap' do
    subject { described_class.new }
    let(:new_bitmap) { instance_double(Bitmap) }
    let(:width) { 5 }
    let(:height) { 5 }

    before do
      allow(Bitmap).to receive(:new).with(width, height).and_return(new_bitmap)
    end

    it 'assigns creates and assigns new bitmap' do
      expect(subject.bitmap).to be_nil
      subject.new_bitmap(width, height)
      expect(subject.bitmap).to eq(new_bitmap)
    end
  end
end
