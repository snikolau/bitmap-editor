require 'spec_helper'

RSpec.describe BitmapEditor::Bitmap do
  describe '.new' do
    it 'stores width and height values' do
      bitmap = described_class.new(5, 8)
      expect(bitmap.width).to eq(5)
      expect(bitmap.height).to eq(8)
    end

    context 'when input size is invalid' do
      it 'raises an exception when size is bigger then limit' do
        expect { described_class.new(described_class::MAX_SIZE+1, 5) }.to raise_error(BitmapEditor::InvalidSize)
        expect { described_class.new(5, described_class::MAX_SIZE+1) }.to raise_error(BitmapEditor::InvalidSize)

        expect { described_class.new(5, described_class::MAX_SIZE) }.to_not raise_error
      end

      it 'raises an exception when size is less then 1' do
        expect { described_class.new(0, 5) }.to raise_error(BitmapEditor::InvalidSize)
        expect { described_class.new(-5, 1) }.to raise_error(BitmapEditor::InvalidSize)

        expect { described_class.new(1, described_class::MAX_SIZE) }.to_not raise_error
      end
    end
  end

  describe '#to_s' do
    subject { described_class.new(4, 3).to_s }
    let(:expected_output) do
      <<~EOS
        O O O O
        O O O O
        O O O O
      EOS
    end

    it 'returns graphical representation of bitmap data' do
     expect(subject).to eq(expected_output)
    end
  end

  describe '#color_pixel' do
    subject { described_class.new(2, 3) }
    let(:expected_output) do
      <<~EOS
        O O
        O O
        O A
      EOS
    end

    it 'changes pixel at given coordinates' do
      subject.color_pixel(1, 2, 'A')
      expect(subject.to_s).to eq(expected_output)
    end

    context 'when coordinates are out of boundaries' do
      it 'raises error' do
        expect { subject.color_pixel(1, 3, 'A') }.to raise_error(BitmapEditor::CoordinatesOutOfBounds)
      end
    end

    context 'when color is invalid' do
      it 'raises invalid color error' do
        expect { subject.color_pixel(1, 1, 'z') }.to raise_error(BitmapEditor::InvalidColor)
      end
    end
  end

  describe '#coordinates_within_bounds?' do
    subject { described_class.new(25, 45) }
    specify { expect(subject.coordinate_within_bounds?(0, 0)).to be_truthy }
    specify { expect(subject.coordinate_within_bounds?(-0, 3)).to be_truthy }
    specify { expect(subject.coordinate_within_bounds?(24, 44)).to be_truthy }
    specify { expect(subject.coordinate_within_bounds?(25, 44)).to be_falsy }
    specify { expect(subject.coordinate_within_bounds?(24, 45)).to be_falsy }
    specify { expect(subject.coordinate_within_bounds?(-1, 44)).to be_falsy }
  end

  describe '#reset' do
    subject { described_class.new(2, 1) }

    it 'resets bitmap contents' do
      subject.color_pixel(0,0, 'A')
      expect(subject.to_s).to eq("A O\n")

      subject.reset
      expect(subject.to_s).to eq("O O\n")
    end
  end
end
