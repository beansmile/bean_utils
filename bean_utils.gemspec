require_relative "lib/bean_utils/version"

Gem::Specification.new do |spec|
  spec.name        = "bean_utils"
  spec.version     = BeanUtils::VERSION
  spec.authors     = ["dino"]
  spec.email       = ["dino@beansmile.com"]
  spec.homepage    = "https://www.beansmile.com"
  spec.summary     = "BeanUtils."
  spec.description = "BeanUtils."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://github.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/beansmile/bean_utils.git"
  spec.metadata["changelog_uri"] = "https://github.com/beansmile/bean_utils.git"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "> 6"
  spec.add_dependency "tencentcloud-sdk-sms", ">= 3.0.568"
  spec.add_dependency "tencentcloud-sdk-faceid", ">= 3.0.568"
end
