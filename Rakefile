desc 'build necessary assemblies for tests'
task 'spec/ClassLibrary.dll' do
  system "msbuild spec/ClassLibrary.csproj"
end

desc 'copy test assemblies to spike directory'
task 'spikes/ClassLibrary.dll' => 'spec/ClassLibrary.dll' do
  File.cp 'spec/ClassLibrary.dll','spikes/ClassLibrary.dll'
end

task :compile => 'spec/ClassLibrary.dll'

desc 'run specs with bacon on ironruby'
task :spec => :compile do
  system "ibacon -a"
end

(1..4).each do |i|
  desc "run spike #{i}"
  task "spike#{i}" => 'spikes/ClassLibrary.dll' do
    require "spike/experiment#{i}"
  end
end
