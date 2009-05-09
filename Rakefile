desc 'build necessary assemblies for tests'
task 'spec/ClassLibrary.dll' => FileList["spec/**/*.cs"] do
  system "csc /target:library /out:spec\\ClassLibrary.dll  spec\\*.cs"
end

task :compile => 'spec/ClassLibrary.dll'

desc 'run specs with bacon on ironruby'
task :bacon => :compile do
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
    gemspec.email = "mark@ryall.name"
    gemspec.homepage = "http://github.com/markryall/orangutan"
    gemspec.description = "A mocking library that supports creation of ironruby mock objects (in addition to pure ruby ones)"
    gemspec.files = FileList["[A-Z]*", "{lib,spec}/**/*.{rb,cs}"]
    gemspec.authors = ["Mark Ryall"]
    gemspec.rubyforge_project = 'orangutan'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
