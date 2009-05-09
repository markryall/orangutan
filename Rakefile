desc 'build necessary assemblies for tests'
task 'spec/ClassLibrary.dll' do
  system "msbuild spec/ClassLibrary.csproj"
end

task :compile => 'spec/ClassLibrary.dll'

desc 'run specs with bacon on ironruby'
task :spec => :compile do
  system "ibacon -Ispec -a"
end

(1..4).each do |i|
  desc "run spike #{i}"
  task "spike#{i}" do
    system "ir -I spec -I spikes spikes\\experiment#{i}.rb"
  end
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "orangutan"
    gemspec.summary = "A mock objects library"
    gemspec.email = "mark@tyall.name"
    gemspec.homepage = "http://github.com/markryall/orangutan"
    gemspec.description = "A mocking library that supports creation of ironruby mock objects (in addition to pure ruby ones)"
    gemspec.authors = ["Mark Ryall"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end