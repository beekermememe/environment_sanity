class ConstantExtractor

  def self.open_file(filename_and_path)
    result = []
	  begin
      File.open(filename_and_path) do |f|
        f.each_line do |l|
          result.push(l.strip)
        end
        return result
      end
    rescue Exception => e
      return "Error File #{filename_and_path} cannot be opened"
    end
  end
	
  def self.extract_constants(array_of_lines_from_file)
    lines_without_comments = self.extract_comments(array_of_lines_from_file)
    hash_of_constants = self.extract_constant_definitions(lines_without_comments)
  end

  def self.extract_comments(array_of_lines)
    results = []
    array_of_lines.each do |line|
      newline = line.gsub(/^\s*/,"") # remove indents
      newline = newline.gsub(/\#.*/,"")
      results.push(newline) unless newline == ""
    end
    results
  end
  
  def self.extract_constant_definitions(array_of_lines)
    results = {}
    array_of_lines.each do |line|
      match_found_check = line.match(/([A-Z_0-9]+)\s+=\s+(.+)/)
      unless match_found_check.nil?
        unless results[match_found_check[1]].nil?
          return {"error" => "Error duplicate entries for - #{match_found_check[1]}"}
        end
        results[match_found_check[1]] = match_found_check[2]
      end
    end
    return results
  end

end
