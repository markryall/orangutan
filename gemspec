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
  s.files = Dir['lib/**/*'] + ['README', 'MIT-LICENSE']
end