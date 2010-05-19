Gem::Specification.new do |s|
  s.name = 'orangutan'
  s.version = '0.0.7'
  s.summary = 'A mock objects library'
  s.description = <<-EOF
Yet another test spy style mocking library that happens to support clr testing via ironruby
EOF
  s.authors << 'Mark Ryall'
  s.email = 'mark@ryall.name'
  s.homepage = %q{http://github.com/markryall/orangutan}
  s.files = Dir['lib/**/*'] + ['README.rdoc', 'MIT-LICENSE']

  s.add_development_dependency 'rake', '~>0.8.7'
  s.add_development_dependency 'rspec', '~>1.3.0'
  s.add_development_dependency 'gemesis', '~>0.0.3'
  s.add_development_dependency 'splat', '~>0.1.0'
end
