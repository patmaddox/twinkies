# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twinkies}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pat Maddox"]
  s.date = %q{2009-01-09}
  s.description = %q{TODO}
  s.email = %q{pat.maddox@gmail.com}
  s.executables = ["twinkies"]
  s.files = Dir["[A-Z]*.*", "{bin,generators,lib,test,spec}/**/*"]
  s.homepage = %q{http://github.com/pat-maddox/twinkies}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.add_dependency 'bmizerany-sinatra'
  s.add_dependency 'dm-core'
  s.add_dependency 'do_sqlite3'
  s.add_dependency 'guid'
  s.add_dependency 'twitter'

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
