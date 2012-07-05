class ConfigComparer
  def initialize(params = {})
    @allow_non_master_to_have_more_constants = params[:non_master_can_have_more_consants]
    @log_differences_in_values = params[:log_differences_in_values]
    @verbose = params[:verbose]
    @master_list = params[:master_list]
    @lists_to_match_master_list = params[:lists_to_match_master_list]
    @filenames_to_ignore = params[:filenames_to_ignore]
    @differences = {}
    @pass_fail = {}
    @lists_to_match_master_list.each { |list_entry| @differences[list_entry[:filename]] = [] ; @pass_fail[list_entry[:filename]] = ""}
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





end
