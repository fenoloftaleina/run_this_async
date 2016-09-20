# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'run_this_async/version'

Gem::Specification.new do |spec|
  spec.name          = "run_this_async"
  spec.version       = RunThisAsync::VERSION
  spec.authors       = ["Dominik Bylica"]
  spec.email         = ["byldominik+fenoloftaleina@gmail.com"]

  spec.summary       = %q{RunThisAsync allows you to call any chain of methods on a class (or object) asynchronously inside a sidekiq job.}
  spec.homepage      = "https://github.com/fenoloftaleina/run_this_async"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "sidekiq", "~> 3.0"
  spec.add_runtime_dependency "concord", "~> 0.1.4"
  spec.add_runtime_dependency "procto", "~> 0.0.3"
end
