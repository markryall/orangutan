Gem::Specification.new do |s|
  s.name = 'orangutan'
  s.version = '0.0.6'
  s.summary = 'A mock objects library'
  s.description = <<-EOF
A mocking library that supports creation of ironruby mock objects (in addition to pure ruby ones)
EOF
  s.authors << 'Mark Ryall'
  s.email = 'mark@ryall.name'
  s.homepage = %q{http://github.com/markryall/orangutan}
  s.files = Dir['lib/**/*'] + ['README', 'MIT-LICENSE']
end