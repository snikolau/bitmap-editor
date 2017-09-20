class CommandParser
  def run(file)
    return puts "File does not exist #{file}" if !file || !File.exist?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when 'S'
        puts "There is no image."
      else
        puts 'Unrecognised command.'
      end
    end
  end
end
