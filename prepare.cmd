call path_git
call path_ironruby
call path_msbuild

pushd %IRONRUBY_HOME%
git pull
msbuild Merlin\Main\Languages\Ruby\Ruby.sln
popd