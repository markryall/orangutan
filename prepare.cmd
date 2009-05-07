call path_git
call path_bacon
call path_ironruby
call path_msbuild
pushd %BACON_HOME%
git pull
popd
pushd %IRONRUBY_HOME%
git pull
msbuild Merlin\Main\Languages\Ruby\Ruby.sln
popd
