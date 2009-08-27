require 'rake'
require 'spec/rake/spectask'
require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = %q{pft}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Iván Valdés"]
  s.date = %q{2009-09-27}
  s.description = %q{pft is a simple command line twitter client.}
  s.email = %q{iv@nvald.es}
  s.extra_rdoc_files = ["README.textile", "LICENSE"]
  s.files = ["bin/pft", "lib/pft.rb", "lib/pft/base.rb", "lib/pft/tiny_url.rb", "lib/pft/oauth.rb", "spec/base_spec.rb", "spec/oauth_spec.rb", "spec/tiny_url_spec.rb"]
  s.has_rdoc = false
  s.homepage = %q{http://github.com/ivanvc/pft}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.executables << 'pft'
  s.summary = %q{pft is a command line twitter client.}
  s.post_install_message = %q{pft! this is ridiculous}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<twitter>, [">= 0.6.15"])
      s.add_runtime_dependency(%q<ivanvc-choice>, [">= 0.1.3.1"])
      s.add_runtime_dependency(%q<highline>, [">= 1.5.1"])
    else
      s.add_dependency(%q<twitter>, [">= 0.6.15"])
      s.add_dependency(%q<ivanvc-choice>, [">= 0.1.3.1"])
      s.add_dependency(%q<highline>, [">= 1.5.1"])
    end
  else
    s.add_dependency(%q<twitter>, [">= 0.6.15"])
    s.add_dependency(%q<ivanvc-choice>, [">= 0.1.3.1"])
    s.add_dependency(%q<highline>, [">= 1.5.1"])
  end
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end

desc 'Default: run specs.'
task :default => :spec

desc 'Run all examples'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/*_spec.rb']
end