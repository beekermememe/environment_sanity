class ConfigComparer

  attr_reader :allow_non_master_to_have_more_constants,
    :log_differences_in_values,
    :verbose,
    :master_list,
    :lists_to_match_master_list,
    :filenames_to_ignore,
    :differences,
    :pass_fail,
    :lists_to_match_master_list,
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
        compare_list_to_master
      end
      show_differences if @log_differences_in_value
      show_results
    end
  end

  def create_master_array


  end

  def compare_list_to_master


  end

  def show_results


  end

  def show_differences


  end

  def preflight_check
    if @lists_to_match_master_list.nil?
      return "FAIL - No files to compare"
    elsif @master_list.nil?
      return "FAIL - Master list empty"
    elsif !@list_of_constants_that_must_match.nil? && !@list_of_constants_that_must_match.is_a?(Array)
      return "FAIL - list of constants must be an Array"
    elsif check_file_formats != "PASS"
      return "FAIL - #{check_file_formats}"
    elsif !@list_of_constants_that_must_match.nil? && master_contains_match_constants == "PASS"
      return "FAILS - #{master_contains_match_constants}"
    end
  end



end