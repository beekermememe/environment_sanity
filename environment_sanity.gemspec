# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "environment_sanity/version"

Gem::Specification.new do |s|
  s.name        = "environment_sanity"
  s.version     = EnvironmentSanity::VERSION
  s.authors     = ["beekermememe"]
  s.email       = ["bkeogh123@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

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
