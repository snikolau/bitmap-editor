require 'spec_helper'

RSpec.describe CommandParser do
  describe 'command parsing' do
    let(:editor) { instance_double(BitmapEditor) }
    subject { described_class.new(editor).run('not_important') }

    before do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:open).and_return(input)
    end

    context 'showing image' do
      let(:input) { StringIO.new("S") }
      it 'calls editor to show bitmap' do
        expect(editor).to receive(:bitmap)
        subject
      end
    end

    context 'creating image' do
      let(:input) { StringIO.new("I 5 5") }

      it 'calls editor to create new bitmap with valid parameters' do
        expect(editor).to receive(:new_bitmap).with(5, 5)
        subject
      end

      context 'when parameters are invalid' do
        let(:input) { StringIO.new("I 1 1 A") }
        it 'throws an error when parameters are invalid' do
          expect { subject }.to raise_error(CommandParser::UnexpectedParameters)
        end
      end
    end

    context 'pixel coloring' do
      let(:input) { StringIO.new("L 1 1 A") }

      it 'calls editor to change pixel color at converted coordinates' do
        expect(editor).to receive(:color_pixel).with(0, 0, 'A')
        subject
      end

      context 'when parameters are invalid' do
        let(:input) { StringIO.new("L 1 1") }
        it 'throws an error when parameters are invalid' do
          expect { subject }.to raise_error(CommandParser::UnexpectedParameters)
        end
      end
    end
  end
end
