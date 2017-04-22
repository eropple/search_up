# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "search_up/version"

Gem::Specification.new do |spec|
  spec.name          = "search_up"
  spec.version       = SearchUp::VERSION
  spec.authors       = ["Ed Ropple"]
  spec.email         = ["ed+searchup@edropple.com"]

  spec.summary       = "A simple utility for recursively searching upward for a file or directory."
  spec.homepage      = "https://github.com/eropple/search_up"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
