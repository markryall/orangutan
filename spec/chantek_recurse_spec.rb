require File.dirname(__FILE__) + '/spec_helper'

describe 'creating recursive ruby stubs' do
  before do
    @foo = stub :foo, :recursive => true
  end
  
  it "should return the same object when generating a stub for the same name" do
    @foo.__id__.should. == stub(:foo).__id__
  end
  
  it "should return nil instead of new stub when instructed to" do
    so_when(:foo).receives(:bar).return(nil)
    @foo.bar.should == nil
  end

  it "should return new stubs from each method call" do
    bar = @foo.bar
    baz = bar.baz
    calls.should == [call(:foo, :bar), call(:"foo/bar", :baz)]
  end

  it "should create recursive stubs" do
    @foo.a.b.c
    stub_names.map{|s|s.to_s}.sort.should == ['foo', 'foo/a', 'foo/a/b', 'foo/a/b/c']
  end
end
