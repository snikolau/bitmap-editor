class CommandParser
  UnexpectedParameters = Class.new(StandardError)

  def initialize(editor = BitmapEditor.new)
    @editor = editor
  end

  def run(file)
    return puts "File does not exist #{file}" if !file || !File.exist?(file)

    File.open(file).each do |line|
      command, *params = line.chomp.split(' ')
      case command
      when 'S'
        puts editor.bitmap
      when 'I'
        editor.new_bitmap(*new_bitmap_parameters(params))
      when 'L'
        editor.color_pixel(*color_pixel_parameters(params))
      else
        puts 'Unrecognised command.'
      end
    end
  end

  private

  attr_reader :editor

  def new_bitmap_parameters(params)
    raise UnexpectedParameters, "Parameters: #{params}" unless params.size == 2
    params.take(2).map(&:to_i)
  end

  def color_pixel_parameters(params)
    raise UnexpectedParameters, "Parameters: #{params}" unless params.size == 3
    params.take(2).map { |el| el.to_i - 1 }  << params.last
  end
end
