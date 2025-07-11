# frozen_string_literal: true

require_relative "lib/mecha_browser/version"

Gem::Specification.new do |spec|
  spec.name = "mecha_browser"
  spec.version = MechaBrowser::VERSION
  spec.authors = ["src"]
  spec.email = ["src@srcw.net"]

  spec.summary = "Mecha Browser - A Ruby gem for browsing the web with a mechanical approach."
  spec.description = "Mecha Browser is a Ruby gem that allows users to browse the web programmatically, automating interactions with web pages and extracting information in a mechanical fashion."
  spec.homepage = "https://srcw.net"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  #  spec.metadata["source_code_uri"] = "https://github.com/src256/mecha_browser"
  #  spec.metadata["changelog_uri"] = "https://github.com/src256/mecha_browser/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "web_loader"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
