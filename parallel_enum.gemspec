# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parallel_enum/version'

Gem::Specification.new do |spec|
  spec.name          = "parallel_enum"
  spec.version       = ParallelEnum::VERSION
  spec.authors       = ["Brian Abreu"]
  spec.email         = ["brian@nuts.com"]
  spec.description   = %q{A simple library for parallelizing enumeration}
  spec.summary       = %q{Parallel enum is a very simple library for processing Enumerables on multiple threads.}
  spec.homepage      = "https://github.com/brewski/parallel_enum"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "agent"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
