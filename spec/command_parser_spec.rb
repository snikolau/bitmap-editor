require 'spec_helper'

RSpec.describe BitmapEditor::CommandParser do
  describe 'command parsing' do
    let(:editor) { instance_double(BitmapEditor::Editor) }
    subject { described_class.new(editor).run('not_important') }

    before do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:open).and_return(input)
    end

    context 'showing image' do
      let(:input) { StringIO.new('S') }

      before do
        allow($stdout).to receive(:puts).and_return(nil)
      end

      it 'calls editor to show bitmap' do
        expect(editor).to receive(:bitmap)
        subject
      end
    end

    context 'creating image' do
      let(:input) { StringIO.new('I 5 5') }

      it 'calls editor to create new bitmap with valid parameters' do
        expect(editor).to receive(:new_bitmap).with(5, 5)
        subject
      end

      context 'when parameters are invalid' do
        let(:input) { StringIO.new('I 1 1 A') }
        it 'prints an error when parameters are invalid' do
          expect { subject }.to output(/Error/).to_stdout
        end
      end
    end

    context 'pixel coloring' do
      let(:input) { StringIO.new('L 1 1 A') }

      it 'calls editor to change pixel color at converted coordinates' do
        expect(editor).to receive(:color_pixel).with(0, 0, 'A')
        subject
      end

      context 'when parameters are invalid' do
        let(:input) { StringIO.new('L 1 1') }
        it 'prints an error when parameters are invalid' do
          expect { subject }.to output(/Error/).to_stdout
        end
      end
    end

    context 'vertical line draw' do
      let(:input) { StringIO.new('V 2 1 4 U') }

      it 'calls editor to draw vertical line with converted coordinates' do
        expect(editor).to receive(:draw_vertical_segment).with(1, 0, 3, 'U')
        subject
      end

      context 'when parameters are invalid' do
        let(:input) { StringIO.new('V 1 1') }
        it 'prints an error when parameters are invalid' do
          expect { subject }.to output(/Error/).to_stdout
        end
      end
    end

    context 'horizontal line draw' do
      let(:input) { StringIO.new('H 2 3 4 H') }

      it 'calls editor to draw horizontal line with converted coordinates' do
        expect(editor).to receive(:draw_horizontal_segment).with(1, 2, 3, 'H')
        subject
      end

      context 'when parameters are invalid' do
        let(:input) { StringIO.new('H 1 1 1') }
        it 'prints an error when parameters are invalid' do
          expect { subject }.to output(/Error/).to_stdout
        end
      end
    end

    context 'clear bitmap' do
      let(:input) { StringIO.new('C') }

      it 'calls editor to clean bitmap' do
        expect(editor).to receive(:clean_bitmap)
        subject
      end
    end
  end
end
