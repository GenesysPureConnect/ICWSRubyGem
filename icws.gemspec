Gem::Specification.new do |s|
  s.name               = "icws"
  s.version = "2.3.2"
  s.default_executable = "icws"
  s.date    = Date.today.to_s

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kevin Glinski"]
  s.licenses = ['MPLv2']
  s.description = %q{Ruby wrapper around ICWS}
  s.email = %q{kevin.glinski@inin.com}
  s.files = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md", "RAKEFILE"]
  s.homepage = %q{https://github.com/InteractiveIntelligence/ICWSRubyGem}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{open source Ruby wrapper around ICWS}
  s.add_dependency "rest-client", "1.7.2"
  s.add_dependency "json", "1.8.1"

  s.add_development_dependency 'rake'

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
