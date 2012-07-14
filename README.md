## Welcome to the environment_sanity wiki!

In a recent spate of issues, we found ourselves deploying code with missing constants in the production.rb environment file. The goal of this gem is to provide a simple utility where
Environment files can be passed
* A master environment file can be specified
* A list of environment files to be compared to the master list can be found
* The constants from each file can be extracted and compared
* A simple "PASS","FAIL" can be generated as the output if not all of the files contain the required constants

This can be added into any test/spec

it "should have at least the same constants in the stage.rb file as that are in the qa.rb file" do
  config_check = EnvironmentSanity.check({:master => "./config/environments/qa.rb", :files_to_match => [ "./config/environments/stage.rb" ]})
  config_check.should be "PASS", "stage. is missing some constants"
end


