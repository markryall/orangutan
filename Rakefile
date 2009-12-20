desc 'build necessary assemblies for tests'
task 'spec/ClassLibrary.dll' => FileList["spec/**/*.cs"] do
  system "csc /target:library /out:spec\\ClassLibrary.dll  spec\\clr\\*.cs"
end

task :compile => 'spec/ClassLibrary.dll'

desc 'specs'
task :spec => :compile do
  system "spec spec"
end

(1..4).each do |i|
  desc "run spike #{i}"
  task "spike#{i}" do
    system "ir -I spec -I spikes spikes\\experiment#{i}.rb"
  end
end