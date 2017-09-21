require 'spec_helper'

RSpec.describe BitmapEditor::NullBitmap do
  describe '#to_s' do
    it 'returns information that bitmap is not initialized' do
      expect(described_class.new.to_s).to eq('Bitmap is not initialized.')
    end
  end

  describe '#color_pixel' do
    it 'raises bitmap not initialized error' do
      expect { subject.color_pixel(0, 0, 0) }.to raise_error BitmapEditor::BitmapNotInitialized
    end
  end

  describe '#coordinate_within_bounds?' do
    it 'raises bitmap not initialized error' do
      expect { subject.coordinate_within_bounds?(0, 0) }.to raise_error BitmapEditor::BitmapNotInitialized
    end
  end

  describe '#reset' do
    it 'raises bitmap not initialized error' do
      expect { subject.reset }.to raise_error BitmapEditor::BitmapNotInitialized
    end
  end
end
