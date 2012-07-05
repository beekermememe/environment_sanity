# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "environment_sanity/version"

Gem::Specification.new do |s|
  s.name        = "environment_sanity"
  s.version     = EnvironmentSanity::VERSION
  s.authors     = ["beekermememe"]
  s.email       = ["bkeogh123@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A Gem that provides the ability to compare constants in different environment files}
  s.description = %q{I had an issue with many environments QA,INT,STAGING,PRODUCTION and missing constants during deploy. This GEM provides support to check the existance of CONSTANTS from a master environment file. My use case is I use this in a spec file and also a preflight check in my cap deploy to make sure that production has all the constants defined in QA.}

  s.rubyforge_project = "environment_sanity"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "pry"
end
