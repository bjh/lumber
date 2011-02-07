# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lumber/version"

Gem::Specification.new do |s|
  s.name        = "lumber"
  s.version     = Lumber::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["bjh"]
  s.email       = ["bjh@nowhere.com"]
  s.homepage    = ""
  s.summary     = %q{a logger in A minor}
  s.description = %q{what is this that stands before me?}

  s.rubyforge_project = "lumber"
  s.add_dependency 'ssoroka-ansi'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
