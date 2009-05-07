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
