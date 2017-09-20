require 'spec_helper'

RSpec.describe Bitmap do
  describe '.new' do
    it 'stores width and height values' do
      bitmap = described_class.new(5, 8)
      expect(bitmap.width).to eq(5)
      expect(bitmap.height).to eq(8)
    end

    context 'when input size is invalid' do
      it 'raises an exception when size is bigger then limit' do
        expect { described_class.new(described_class::MAX_SIZE+1, 5) }.to raise_error(Bitmap::InvalidSize)
        expect { described_class.new(5, described_class::MAX_SIZE+1) }.to raise_error(Bitmap::InvalidSize)

        expect { described_class.new(5, described_class::MAX_SIZE) }.to_not raise_error
      end

      it 'raises an exception when size is less then 1' do
        expect { described_class.new(0, 5) }.to raise_error(Bitmap::InvalidSize)
        expect { described_class.new(-5, 1) }.to raise_error(Bitmap::InvalidSize)

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
end
