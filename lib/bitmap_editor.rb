class BitmapEditor

  def run(file)
    return puts "#{file} please provide correct file" if file.nil? || !File.exists?(file)

  end
end
