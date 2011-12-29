class Decipher

  def do_decipher(file_path)
    output = "";
    File.open(file_path) do |file|
      while content = file.gets
        content.to_s().each_byte do |c|
          output += "#{(c-7).chr}"
        end
      end
    end
    return output
  end

end
