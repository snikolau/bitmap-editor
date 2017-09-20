require 'spec_helper'

RSpec.describe CommandParser do
  describe '#run' do
    let(:file) { File.expand_path('spec/fixtures/example.txt') }
    let(:expected_output) do
      <<~EOS
        O O O W
        J J J J
        U O O O
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
  end
end
