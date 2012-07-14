module EnvironmentSanityCore

  def initialize(config)
    @master_file = config[:master_file]
    @test_files = config[:test_files]
    @show_diffs = config[:show_diffs]
    @constants_that_must_match = config[:constants_that_must_match]
    @test_files_can_have_more_constants = config[:test_files_can_have_more_constants]

  end

  def run_test
    constants = load_configs
    if load_configs["error"]
      return load_configs["error"]
    end

    comparison_result = run_comparisons(constants)
    return comparison_result
  end

  def load_configs
    cl = ConfigLoader.new(@master_file,@test_files)
    read_results = cl.read_files
    read_results
  end

  def run_comparisons(constants)
    #leave out the master file in the test file list

    testfiles = []; constants.each { |file| testfiles.push(file) if file[:master].nil?}
    
    compare_params = {
      :non_master_can_have_more_consants => @test_files_can_have_more_constants,
      :log_differences_in_values => @show_diffs,
      :master_list => constants[:master],
      :lists_to_match_master_list => testfiles,
      :list_of_constants_that_must_match => @constants_that_must_match
    }
    
    comparer = ConfigComparer.new(compare_params)
    return comparer.compare_to_master
  end

end
