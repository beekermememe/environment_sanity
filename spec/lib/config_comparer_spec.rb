require [File.dirname(__FILE__),"/../spec_helper"].join

describe ConfigComparer do
  context "initialize" do
    before :each do
      @list1= {'int' => {
        'WATCHMUST' => 12345,
        'NOTSO_IMPORTANT' => '12345'
        }
      }
      @list2= {'production' => {
        'WATCHMUST' => 12345,
        'NOTSO_IMPORTANT' => '12346'
        }
      }
      @master_list= {'qa' => {
        'WATCHMUST' => 12345,
        'NOTSO_IMPORTANT' => '12346'
        }
      }

      @happy_path_params = {
        :non_master_can_have_more_consants => true,
        :log_differences_in_values => true,
        :verbose => true,
        :lists_to_match_master_list => [@list1,@list2],
        :filenames_to_ignore => ['int'],
        :list_of_constants_that_must_match => ['MATCHMUST'],
        :master_list => @master_list,
        :allow_non_master_to_have_more_constants => true
      }
      @cc = ConfigComparer.new(@happy_path_params)
    end

    it "should assign the list of files to check" do
      @cc.lists_to_match_master_list.should == [@list1,@list2]
    end
  
    it "should assign the master file" do
      @cc.master_list.should == @master_list
    end 

    it "should assign the parameter to output the differences" do
      @cc.log_differences_in_values.should == true
    end

    it "should assign the parameter to specify files to skip" do
      @cc.filenames_to_ignore.should == ['int']
    end

    it "should assign the parameter that is a list of parameters that need to match exactly" do
      @cc.list_of_constants_that_must_match.should == ['MATCHMUST']
    end

    it "should assign an empty array to the parameters that must be skipped if not specified" do
      
    end

    it "should prepare the differences hash" do
       @cc.differences.is_a?(Hash).should == true
    end

    it "should prepare the pass_fail hash" do
       @cc.pass_fail.is_a?(Hash).should == true
    end

    it "should populate the verbose parameter" do
       @cc.verbose.should == true
    end

    it "should populate the flag to allow the files to have more constants than the master" do
       @cc.allow_non_master_to_have_more_constants.should == true
    end
  end

  context "preflight check" do
    before :each do
      @list1= {'int' => {
        'MATCHMUST' => 12345,
        'NOTSO_IMPORTANT' => '12345'
        }
      }
      @list2= {'production' => {
        'MATCHMUST' => 12345,
        'NOTSO_IMPORTANT' => '12346'
        }
      }

      @bad_format_list = {'a banana' => []}

      @master_list= {'qa' => {
        'MATCHMUST' => 12345,
        'NOTSO_IMPORTANT' => '12346'
        }
      }

      @happy_path_params = {
        :non_master_can_have_more_consants => true,
        :log_differences_in_values => true,
        :verbose => true,
        :lists_to_match_master_list => [@list1,@list2],
        :filenames_to_ignore => ['int'],
        :list_of_constants_that_must_match => ['MATCHMUST'],
        :master_list => @master_list,
        :allow_non_master_to_have_more_constants => true
      }

      @no_master_file_params = {
        :non_master_can_have_more_consants => true,
        :log_differences_in_values => true,
        :verbose => true,
        :lists_to_match_master_list => [@list1,@list2],
        :filenames_to_ignore => ['int'],
        :list_of_constants_that_must_match => ['MATCHMUST'],
        :allow_non_master_to_have_more_constants => true
      }

      @no_files_to_compare_params = {
        :non_master_can_have_more_consants => true,
        :log_differences_in_values => true,
        :verbose => true,
        :filenames_to_ignore => ['int'],
        :list_of_constants_that_must_match => ['MATCHMUST'],
        :master_list => @master_list,
        :allow_non_master_to_have_more_constants => true
      }

      @bad_format_list_params = {
        :non_master_can_have_more_consants => true,
        :log_differences_in_values => true,
        :verbose => true,
        :lists_to_match_master_list => [@bad_format_list,@list2],
        :filenames_to_ignore => ['int'],
        :list_of_constants_that_must_match => ['MATCHMUST'],
        :master_list => @master_list,
        :allow_non_master_to_have_more_constants => true
      }

      @bad_master_format_param = {
        :non_master_can_have_more_consants => true,
        :log_differences_in_values => true,
        :verbose => true,
        :lists_to_match_master_list => [@list1,@list2],
        :filenames_to_ignore => ['int'],
        :list_of_constants_that_must_match => ['MATCHMUST'],
        :master_list => @bad_format_list_params,
        :allow_non_master_to_have_more_constants => true
      }


      @bad_constants_list_params = {
        :non_master_can_have_more_consants => true,
        :log_differences_in_values => true,
        :verbose => true,
        :lists_to_match_master_list => [@list1,@list2],
        :filenames_to_ignore => ['int'],
        :list_of_constants_that_must_match => {'MATCHMUST' => true},
        :master_list => @master_list,
        :allow_non_master_to_have_more_constants => true
      }

      @no_files_to_compare_params = {
        :non_master_can_have_more_consants => true,
        :log_differences_in_values => true,
        :verbose => true,
        :filenames_to_ignore => ['int'],
        :list_of_constants_that_must_match => ['MATCHMUST'],
        :master_list => @master_list,
        :allow_non_master_to_have_more_constants => true
      }

      @constant_not_in_master_params = {
        :non_master_can_have_more_consants => true,
        :log_differences_in_values => true,
        :verbose => true,
        :lists_to_match_master_list => [@list1,@list2],
        :filenames_to_ignore => ['int'],
        :list_of_constants_that_must_match => ['MATCHMUSTMISSING'],
        :master_list => @master_list,
        :allow_non_master_to_have_more_constants => true
      }
    end
    it "should fail if no master file is present" do
      pending
    end

    it "should fail if no files to compare are present" do
      @cc = ConfigComparer.new(@no_files_to_compare_params)
      @cc.preflight_check.should == "FAIL - No files to compare"
    end

    it "should fail if the files to compare are not in the correct format" do
      @cc = ConfigComparer.new(@bad_format_list_params)
      @cc.preflight_check.should == "FAIL - File to compare is incorrect format"
    end

    it "should fail if the master file is not in the correct format" do
      @cc = ConfigComparer.new(@bad_master_format_param)
      @cc.preflight_check.should == "FAIL - Master is incorrect format"
    end

    it "should fail if the constants to match are not in the correct format" do
      @cc = ConfigComparer.new(@bad_constants_list_params)
      @cc.preflight_check.should == "FAIL - list of constants must be an Array"
    end

    it "should fail if the constants to match are not in the master file" do
      @cc = ConfigComparer.new(@constant_not_in_master_params)
      @cc.preflight_check.should == "FAIL - Master does not have constant - MATCHMUSTMISSING"
    end

    it "should pass preflight if all parameters are in order" do
      @cc=ConfigComparer.new(@happy_path_params)
      @cc.preflight_check.should == "PASS"
    end
  end

  context "running comparision" do

    it "should compare files in the list provided with the master" do
      pending
    end

    it "should mark a file as passed if the same constants are present" do
      pending
    end

    it "should mark a file a passed if it has more constants than the master but it is allowed to" do
      pending
    end

    it "should mark a file as failed if it has more constants than the master but is not allowed to" do
      pending
    end

    it "should mark a file as failed if the list constants do not match exactly" do
      pending
    end

    it "should output differences if the flag to do this is set" do
      pending
    end

    it "should mark a file a failed if it does not match the constants in the master list" do
      pending
    end

    it "should skip a file if it has been configured to" do
      pending
    end
  end
end

