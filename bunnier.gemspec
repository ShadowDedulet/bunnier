# frozen_string_literal: true

require_relative 'lib/bunnier/version'

Gem::Specification.new do |spec|
  spec.name = 'bunnier'
  spec.version = Bunnier::VERSION
  spec.authors = ['Анджэй Евула']
  spec.email = ['shadow_dedulet@mail.ru']

  spec.summary = 'Client for RabbitMQ'
  spec.description = 'Client for Rabbitmq providing convenience and security'
  spec.homepage = 'https://github.com/ShadowDedulet/bunnier'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.4.0'

  spec.metadata['allowed_push_host'] = 'git@github.com:ShadowDedulet/bunnier.git'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ShadowDedulet/bunnier'
  spec.metadata['changelog_uri'] = 'https://github.com/ShadowDedulet/bunnier/blob/master/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('bunny', '~> 2.22')
  spec.add_dependency('logger', '~> 1.5.0')
  spec.add_dependency('rake', '~> 13.0')

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
