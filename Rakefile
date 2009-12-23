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

spec = Gem::Specification.load(File.expand_path('orangutan.gemspec', File.dirname(__FILE__)))

desc "Push new release to gemcutter and git tag"
task :push => :build_gem do
  sh "git tag #{spec.version}"
  sh "gem push #{spec.name}-#{spec.version}.gem"
end

task :build_gem do
  sh "gem build #{spec.name}.gemspec"
end

desc "Install #{spec.name} locally"
task :install => :build_gem do
  sh "gem install #{spec.name}-#{spec.version}.gem --no-ri --no-rdoc"
end

desc "Uninstall #{spec.name} locally"
task :uninstall => :build_gem do
  sh "gem uninstall #{spec.name} -x -a"
end

desc "Reinstall #{spec.name} locally"
task :reinstall => [:uninstall, :install]
