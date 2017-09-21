require 'spec_helper'

RSpec.describe CommandParser do
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
      let(:expected_output) { "Unrecognised command.\n" }
      it 'returns error message about unrecognised command' do
        expect { subject }.to output(expected_output).to_stdout
      end
    end

    context 'input with invalid commands' do
      context 'bitmap is not initialized when operation is executed' do
        let(:file) { File.expand_path('spec/fixtures/example_no_image.txt' ) }
        let(:expected_output) { "Error executing command: \"L 1 1 A\": Bitmap was not initialized yet.\n" }
        it 'returns error message and stops processing' do
          expect { subject }.to output(expected_output).to_stdout
        end
      end
    end
  end
end
