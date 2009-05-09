# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{orangutan}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Ryall"]
  s.date = %q{2009-05-09}
  s.description = %q{A mocking library that supports creation of ironruby mock objects (in addition to pure ruby ones)}
  s.email = %q{mark@ryall.name}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "README",
     "Rakefile",
     "VERSION",
     "lib/orangutan.rb",
     "lib/orangutan/call.rb",
     "lib/orangutan/chantek.rb",
     "lib/orangutan/clean_slate.rb",
     "lib/orangutan/container.rb",
     "lib/orangutan/expectation.rb",
     "lib/orangutan/raiser.rb",
     "orangutan.gemspec",
     "prepare.cmd",
     "spec/ClassWithANonVirtualMethod.cs",
     "spec/ClassWithANonVirtualProperty.cs",
     "spec/ClassWithAVirtualMethod.cs",
     "spec/ClassWithAVirtualProperty.cs",
     "spec/Consumer.cs",
     "spec/IHaveAMethod.cs",
     "spec/IHaveAProperty.cs",
     "spec/IHaveAnEvent.cs",
     "spec/spec_chantek.rb",
     "spec/spec_chantek_clr.rb",
     "spec/spec_expectation.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/markryall/orangutan}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{orangutan}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A mock objects library}
  s.test_files = [
    "spec/spec_chantek.rb",
     "spec/spec_chantek_clr.rb",
     "spec/spec_expectation.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
