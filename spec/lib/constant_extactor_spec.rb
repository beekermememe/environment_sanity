require [File.dirname(__FILE__),"/../spec_helper"].join

describe ConstantExtractor do

  before :each do
    @test_array = []
    @test_array.push(" # This is a comment line")
    @test_array.push(" TEST_VAL1 = 12.3445 # a constant with a comment")
    @test_array.push(" TEST_VAL2 = 'A string constant'")
    @test_array.push(" TEST_VAL3 = ['An Array Constant',1.2]")
    @test_array.push(" local.variable = 'Not a constant'")
    @test_array.push(" TEST_VAL4 = {'a' => 'has type constant'}")
  end

  it "should open the file passed" do
    File.expects(:open).returns(nil)
    ConstantExtractor.open_file("./spec/lib/test_configs/int.rb")
  end


  it "should log an error if it cannot open the file" do
    result = ConstantExtractor.open_file("test_configs/int_not_exist.rb")
    result.should == "Error File test_configs/int_not_exist.rb cannot be opened"
  end

  it "should return a list of the lines to process in an array" do
    result = ConstantExtractor.open_file("./spec/lib/test_configs/int.rb")
    result.is_a?(Array).should be true
  end
  it "should detect all the constants" do
    result = ConstantExtractor.open_file("./spec/lib/test_configs/int.rb")
    result = ConstantExtractor.extract_constants(result)
    result.keys.count.should == 38
  end

  it "should return a hash of the format constant name => value" do
    result = ConstantExtractor.open_file("./spec/lib/test_configs/int.rb")
    result = ConstantExtractor.extract_constants(result)
    result.is_a?(Hash).should == true
  end
  
  it "should assign the key of the result hash to be the constant name" do
    
  end
  
  it "should assign the value of the results hash to be the constant value" do
    
  end

  it "should remove comments" do
    result = ConstantExtractor.extract_comments(@test_array)
    result.size.should == 5
    result.each { |line| line.include?("#").should == false }
  end
end
