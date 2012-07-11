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

    it "should fail if no master file is present" do
      pending
    end

    it "should fail if no files to compare are present" do

    end

    it "should fail if the files to compare are not in the correct format" do

    end

    it "should fail if the master file is not in the correct format" do

    end

    it "should fail if the constants to match are not in the correct format" do

    end

    it "should fail if the constants to match are not in the master file" do

    end

  end

  context "running comparision" do

    it "should compare files in the list provided with the master" do

    end

    it "should mark a file as passed if the same constants are present" do

    end

    it "should mark a file a passed if it has more constants than the master but it is allowed to" do

    end

    it "should mark a file as failed if it has more constants than the master but is not allowed to" do

    end

    it "should mark a file as failed if the list constants do not match exactly" do

    end

    it "should output differences if the flag to do this is set" do

    end

    it "should mark a file a failed if it does not match the constants in the master list" do

    end

    it "should skip a file if it has been configured to" do

    end
  end
end

