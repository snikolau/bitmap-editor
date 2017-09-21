require 'spec_helper'

RSpec.describe BitmapEditor::CommandParser do
  describe '#run' do
    let(:file) { File.expand_path('spec/fixtures/example.txt') }
    let(:expected_output) do
      <<~EOS
        O O X O
        J J X J
        O O X Y
      EOS
    end
    subject { described_class.new.run(file) }

    it 'returns expected input' do
      expect { subject }.to output(expected_output).to_stdout
    end

    context 'when file does not exists' do
      let(:file) { 'random/path' }
      let(:expected_output) { "File does not exist #{file}\n" }

      it 'returns error message about missing file' do
        expect { subject }.to output(expected_output).to_stdout
      end
    end

    context 'when file contains unrecognised command' do
      let(:file) { File.expand_path('spec/fixtures/bad_example.txt' ) }
      let(:expected_output) { "Error executing command: \"G\": Invalid command.\n" }
      it 'returns error message about unrecognised command' do
        expect { subject }.to output(expected_output).to_stdout
      end
    end

    context 'input with invalid commands' do
      context 'when bitmap is not initialized when operation is executed' do
        let(:file) { File.expand_path('spec/fixtures/example_no_image.txt' ) }
        let(:expected_output) { "Error executing command: \"L 1 1 A\": Bitmap was not initialized yet.\n" }
        it 'returns error message and stops processing' do
          expect { subject }.to output(expected_output).to_stdout
        end
      end

      context 'when command has wrong coordinates' do
        let(:file) { File.expand_path('spec/fixtures/example_wrong_coordinates.txt' ) }
        let(:expected_output) { "Error executing command: \"L 5 5 A\": Coordinates are out of bitmap bounds\n" }
        it 'returns error message and stops processing' do
          expect { subject }.to output(expected_output).to_stdout
        end
      end

      context 'when command has wrong color' do
        let(:file) { File.expand_path('spec/fixtures/example_wrong_color.txt' ) }
        let(:expected_output) { "Error executing command: \"L 2 2 8\": Invalid color. It should be single capital letter.\n" }

        it 'returns error message and stops processing' do
          expect { subject }.to output(expected_output).to_stdout
        end
      end

      context 'when bitmap size is invalid' do
        let(:file) { File.expand_path('spec/fixtures/example_wrong_size.txt' ) }
        let(:expected_output) { "Error executing command: \"I 251 251\": " \
                                "Invalid bitmap size. Size should be in range 1 - 250.\n" }

        it 'returns error message and stops processing' do
          expect { subject }.to output(expected_output).to_stdout
        end
      end
    end
  end
end
