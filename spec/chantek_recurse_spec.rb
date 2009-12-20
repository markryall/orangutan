require File.dirname(__FILE__) + '/spec_helper'

module Orangutan
  describe Chantek, 'creating recursive ruby stubs' do
    before do
      @o = Chantek.new
      @foo = @o.stub :foo, :recursive => true
    end
    
    it "should return the same object when generating a stub for the same name" do
      @foo.__id__.should. == @o.stub(:foo).__id__
    end
    
    it "should return nil instead of new stub when instructed to" do
      @o.when(:foo).receives(:bar).return(nil)
      @foo.bar.should == nil
    end

    it "should return new stubs from each method call" do
      bar = @foo.bar
      baz = bar.baz
      @o.calls[0].should == Call.new(:foo, :bar,[])
      @o.calls[1].should == Call.new(:"foo/bar", :baz,[])
    end

    it "should create recursive stubs" do
      @foo.a.b.c
      @o.stubs.keys.should == [:foo, :"foo/a", :"foo/a/b", :"foo/a/b/c"]
    end
  end
end