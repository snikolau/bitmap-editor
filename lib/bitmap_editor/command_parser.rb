module BitmapEditor
  # Parses input command and delegates operations to bitmap editor
  class CommandParser
    def initialize(editor = Editor.new)
      @editor = editor
    end

    def run(file)
      return puts "File does not exist #{file}" if !file || !File.exist?(file)
      File.open(file).each do |line|
        break unless run_command(line)
      end
    end

    private

    attr_reader :editor

    def run_command(input)
      command, *params = input.chomp.split(' ')
      delegate_command(command, params)
      true
    rescue BitmapNotInitialized
      puts command_error(input, 'Bitmap was not initialized yet.')
      false
    rescue CoordinatesOutOfBounds
      puts command_error(input, 'Coordinates are out of bitmap bounds')
      false
    rescue InvalidColor
      puts command_error(input, 'Invalid color. It should be single capital letter.')
      false
    rescue InvalidSize
      puts command_error(input, 'Invalid bitmap size. Size should be in range 1 - 250.')
      false
    rescue InvalidCommand
      puts command_error(input, 'Invalid command.')
      false
    end

    def delegate_command(command, params)
      case command
      when 'S'
        puts editor.bitmap
      when 'I'
        editor.new_bitmap(*new_bitmap_parameters(params))
      when 'L'
        editor.color_pixel(*color_pixel_parameters(params))
      when 'V'
        editor.draw_vertical_segment(*draw_segment_parameters(params))
      when 'H'
        editor.draw_horizontal_segment(*draw_segment_parameters(params))
      when 'C'
        editor.clean_bitmap
      else
        raise InvalidCommand
      end
    end

    def new_bitmap_parameters(params)
      raise InvalidCommand, "Parameters: #{params}" unless params.size == 2
      params.take(2).map(&:to_i)
    end

    def color_pixel_parameters(params)
      raise InvalidCommand, "Parameters: #{params}" unless params.size == 3
      params.take(2).map { |el| el.to_i - 1 } << params.last
    end

    def draw_segment_parameters(params)
      raise InvalidCommand, "Parameters: #{params}" unless params.size == 4
      params.take(3).map { |el| el.to_i - 1 } << params.last
    end

    def command_error(command, description)
      "Error executing command: \"#{command.chomp}\": #{description}"
    end
  end
end
