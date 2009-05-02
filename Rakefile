task 'spec/ClassLibrary.dll' do
  `msbuild spec/ClassLibrary.csproj`
end

task :compile => 'spec/ClassLibrary.dll'

task :spec => :compile do
  `ibacon -a`
end
