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

  describe '#color_pixel' do
    let(:bitmap) { instance_double(Bitmap) }
    subject { described_class.new(bitmap) }

    it 'proxies method call to bitmap' do
      expect(subject.bitmap).to receive(:color_pixel).with(1, 1, 'A')
      subject.color_pixel(1, 1, 'A')
    end
  end

  describe '#draw_vertical_segment' do
    let(:bitmap) { instance_double(Bitmap, coordinate_within_bounds?: true) }
    subject { described_class.new(bitmap) }

    it 'calls pixel coloring at right coordinates to draw segment' do
      expect(subject.bitmap).to receive(:color_pixel).with(1, 2, 'A')
      expect(subject.bitmap).to receive(:color_pixel).with(1, 3, 'A')
      expect(subject.bitmap).to receive(:color_pixel).with(1, 4, 'A')

      subject.draw_vertical_segment(1, 4, 2, 'A')
    end

    context 'when segment is not in bounds' do
      let(:bitmap) { instance_double(Bitmap, coordinate_within_bounds?: false, width: 5, height: 5) }
      it 'it raises error' do
        expect { subject.draw_vertical_segment(1, 10, 11, 'A') }.to raise_error(Bitmap::CoordinatesOutOfBounds)
      end
    end
  end
end
