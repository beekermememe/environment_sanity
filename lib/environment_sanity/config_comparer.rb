class ConfigComparer

  attr_reader :allow_non_master_to_have_more_constants,
    :log_differences_in_values,
    :verbose,
    :master_list,
    :lists_to_match_master_list,
    :filenames_to_ignore,
    :differences,
    :pass_fail,
    :list_of_constants_that_must_match

  def initialize(params = {})
    @allow_non_master_to_have_more_constants = params[:non_master_can_have_more_consants]
    @log_differences_in_values = params[:log_differences_in_values]
    @verbose = params[:verbose]
    @master_list = params[:master_list]
    @lists_to_match_master_list = params[:lists_to_match_master_list]
    @filenames_to_ignore = params[:filenames_to_ignore]
    @differences = {}
    @pass_fail = {}
    @lists_to_match_master_list.each { |list_entry| @differences[list_entry[:filename]] = [] ; @pass_fail[list_entry[:filename]] = ""} unless @lists_to_match_master_list.nil?
    @list_of_constants_that_must_match = params[:list_of_constants_that_must_match].nil? ? [] : params[:list_of_constants_that_must_match]
  end

  def compare_to_master
    if preflight_check == "FAIL"
      return "FAIL: incorrect parameters passed in setup"
    else
      create_master_array
      @lists_to_match_master_list.each do |list_entry|
        @list_to_compare = list_entry
        result = compare_list_to_master
        return result if result.include?("FAIL")
      end
      show_differences if @log_differences_in_value
      return "PASS"
    end
  end

  def preflight_check
    if @lists_to_match_master_list.nil?
      return "FAIL - No files to compare"
    elsif @master_list.nil?
      return "FAIL - Master list empty"
    elsif !@list_of_constants_that_must_match.nil? && !@list_of_constants_that_must_match.is_a?(Array)
      return "FAIL - list of constants must be an Array"
    elsif check_file_formats != "PASS"
      return "#{check_file_formats}"
    elsif !@list_of_constants_that_must_match.nil? && (master_contains_match_constants != "PASS")
      return "#{master_contains_match_constants}"
    end

    return "PASS"
  end

  def check_file_formats

    if !@master_list.is_a?(Hash)
      return "FAIL - Master is incorrect format"
    elsif (@master_list.size != 1)
      return "FAIL - Master is incorrect format"
    elsif !(@master_list.first[1].is_a?(Hash))
      return "FAIL - Master is incorrect format"
    elsif !(@master_list.first[1].size > 0)
      return "FAIL - Master is incorrect format"
    end

    @lists_to_match_master_list.each do |list|
      if !list.is_a?(Hash)
        return "FAIL - File to compare is incorrect format"
      elsif (list.size != 1)
        return "FAIL - File to compare is incorrect format"
      elsif !(list.first[1].is_a?(Hash))
        return "FAIL - File to compare is incorrect format"
      elsif !(list.first[1].size > 0)
        return "FAIL - File to compare is incorrect format"
      end
    end
    return "PASS"
  end

  def master_contains_match_constants
    @list_of_constants_that_must_match.each do |constant_to_match|
      if @master_list.first[1][constant_to_match].nil?
        return "FAIL - Master does not have constant - #{constant_to_match}"
      end
    end
    return "PASS"
  end

  def compare_list_to_master(test_list)
    test_list = @list_to_compare
    @list_of_constants_that_must_match.each do |constant|
      if @master_list.first[1][constant] != test_list[1][constant]
        return "FAIL - Mastet - Test file do not have constant #{constant} matching"
      end
    end
    list_of_constants = @master_list.first[1].each_key.map { |constant| constant }
    test_list[1].each_key do |const|
      if @log_differences_in_values && (@master_list.first[1][const] != test_list[1][const])
        @differences[test_list[0]].push("Constant #{const} #{@master_list.first[1][const]} != #{test_list[1][const]}")
      end
      list_of_constants.delete(const)
    end
    return "FAIL - Test File Missing Constants #{list_of_constants.join(",")}" if list_of_constants.count > 0
    return "PASS"
  end

  def show_differences
    @differences.each do |test_file,diffs|
      puts "#{test_file}"
      diffs.each { |diff| puts "  ---   #{diff}"}
    end
  end
end
