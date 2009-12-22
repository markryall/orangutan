require 'pathname2'

task 'spec/ClassLibrary.dll' => FileList["spec/**/*.cs"] do
  p = Pathname.new('spec')
  compiler = ENV['USE_MONO'] ? 'gmcs' : 'csc'
  sh "#{compiler} /target:library /out:#{p+'ClassLibrary.dll'}  #{p+'clr'+'*.cs'}"
end

desc 'build necessary assemblies for tests'
task :compile => 'spec/ClassLibrary.dll'

desc 'specs'
task :spec => :compile do
  sh "ispec spec"
end

(1..4).each do |i|
  p = Pathname.new('spikes')
  desc "run spike #{i}"
  task "spike#{i}" => :compile do
    sh "ir -I spec -I spikes #{p+'experiment'}#{i}.rb"
  end
end
