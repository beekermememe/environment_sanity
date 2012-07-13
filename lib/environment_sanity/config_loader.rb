class ConfigLoader
  def initialize(master_file,test_files)
    @master_file = master_file
    @test_files = test_files
  end

  def read_files
   result = sanity_check
   return result if result.include?("Error")
 
  # Extract Master File constants 
   results = {}
   result = ConstantExtractor.open_file(@master_file)
   return result if result.is_a?(String) && result.include?("Error") 
   @master_file =~ /([A-Za-z_0-9]+)\.rb/
   master_env = $1
   result = ConstantExtractor.extract_constants(result)
   return result["error"] unless result["error"].nil? 
   results["master"] = result

  # Extract test file constants
   @test_files.each do |filename|
     result = ConstantExtractor.open_file(filename)
     return result if result.is_a?(String) && result.include?("Error") 
     filename =~ /([A-Za-z_0-9]+)\.rb/
     test_env = $1
     result = ConstantExtractor.extract_constants(result)
     return result["error"] unless result["error"].nil? 
     results[test_env] = result
  end
  return results
 end

 def sanity_check
   if @master_file.nil? || !(@master_file.is_a?(String))
     return "Error: Master File is not a string"
   end

   if @test_files.nil? || !(@test_files.is_a?(Array)) || @test_files.length == 0
     return "Error: Test Files are not an Array or Nil or Empty"
   end

   return "pass"
 end
end
