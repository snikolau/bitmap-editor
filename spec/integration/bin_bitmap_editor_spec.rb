RSpec.describe 'bin/bitmap_editor' do
  it 'works as expected' do
    expect(`bin/bitmap_editor spec/fixtures/example.txt`).to eq("O O X O\nJ J X J\nO O X Y\n")
  end
end
