require [File.dirname(__FILE__),"/../spec_helper"].join

describe ConfigLoader do

  it "should check the parameters are correct before proceeding" do
    cl = ConfigLoader.new(nil,nil)
    cl.read_files.should == "Error: Master File is not a string"
  end

  it "should return an error if it cannot open the master file" do
    cl = ConfigLoader.new("Badconfigaddress.rb",["testfile1.rb"])
    cl.read_files.should == "Error File Badconfigaddress.rb cannot be opened"
  end

  it "should return an error if it cannot open a test file" do
    cl = ConfigLoader.new("./spec/lib/test_configs/int.rb",["Badtestconfigfile.rb"])
    cl.read_files.should == "Error File Badtestconfigfile.rb cannot be opened"
  end

  it "should return an error if the file is corrupt" do
    ConstantExtractor.expects(:extract_constants).returns("error" => "Error duplicate constant")
    cl = ConfigLoader.new("./spec/lib/test_configs/int.rb",["Badtestconfigfile.rb"])
    cl.read_files.should == "Error duplicate constant"
  end


  it "should return the master and test constants in a hash if everything is ok" do
    cl = ConfigLoader.new("./spec/lib/test_configs/int.rb",["./spec/lib/test_configs/production.rb"])
    result = cl.read_files

    result["master"].is_a?(Hash).should == true
    result["master"].length.should > 10

    result["production"].is_a?(Hash).should == true
    result["production"].length.should > 10
  end
end
