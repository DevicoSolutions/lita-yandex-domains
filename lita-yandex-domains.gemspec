Gem::Specification.new do |spec|
  spec.name          = "lita-yandex-domains"
  spec.version       = "0.1.0"
  spec.authors       = ["Devico Solutions"]
  spec.email         = ["info@devico.io"]
  spec.description   = "Lita handler to interact with yandex domain API"
  spec.summary       = ""
  spec.homepage      = "https://github.com/DevicoSolutions/lita-yandex-domains"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.3.0'

  spec.add_runtime_dependency 'lita', '>= 4.7'
  spec.add_runtime_dependency 'yandex-pdd-2', '~> 0.1.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
end
