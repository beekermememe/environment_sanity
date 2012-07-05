require [File.dirname(__FILE__),"/../spec_helper"].join

describe ConfigComparer do
  context "initialize" do
    it "should assign the list of files to check" do
      pending
    end
  
    it "should assign the master file" do
      pending
    end 

    it "should assign the parameter to output the differences" do
      pending
    end

    it "should assign the parameter to specify files to skip" do
      pending
    end

    it "should assign the parameter that is a list of parameters that need to match exactly" do
      pending
    end

    it "should assign an empty array to the parameters that must be skipped if not specified" do
      pending
    end

    it "should prepare the differences hash" do
      pending
    end

    it "should prepare the pass_fail hash" do

    end

    it "should populate the verbose parameter" do

    end

    it "should populate the flag to allow the files to have more constants than the master" do

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

