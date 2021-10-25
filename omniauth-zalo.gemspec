
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omniauth/zalo/version"

Gem::Specification.new do |spec|
  spec.name          = "omniauth-zalo"
  spec.version       = Omniauth::Zalo::VERSION
  spec.authors       = ["nguyenthanhcong101096"]
  spec.email         = ["nguyenthanhcong101096@gmail.com"]

  spec.summary       = "this is the all module for wakuwaku appkication"
  spec.description   = "Write a longer description or delete this line."
  spec.homepage      = "https://github.com/nguyenthanhcong101096/omniauth-zalo"
  spec.license       = "Apache-2.0"
  
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.glob("{bin,lib}/**/*")

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency 'web-console', '~> 3.3', '>= 3.3.0'
  # spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'omniauth-oauth2', '~>1.6'
end
