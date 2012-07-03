require [File.dirname(__FILE__),"/../spec_helper"].join

describe "ExtractConstant" do

  it "should open the file passed" do
    File.expects(:open).returns(nil)
    ConstantExtractor.open_file("test_configs/int.rb")
  end

  it "should log an error if it cannot open the file" do
    result = ConstantExtractor.open_file("test_configs/int_not_exist.rb")
    result.should == "Error File test_configs/int_not_exist.rb cannot be opened"
  end

  it "should detect all the constants" do
    result = ConstantExtractor.open_file("test_configs/int.rb")
    result.keys.count.should == 38
  end

  it "should return a hash of the format constant name => value" do
    result = ConstantExtractor.open_file("test_configs/int.rb")
    result.is_a(Hash).should == true
  end
  
  it "should assign the key of the result hash to be the constant name" do
    
  end
  
  it "should assign the value of the results hash to be the constant value" do
    
  end
end
