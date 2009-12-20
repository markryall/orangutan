require File.dirname(__FILE__) + '/spec_helper'

module Orangutan
  describe Expectation do
    before do
      @e = Expectation.new.receives(:foo)
    end
  
    it 'should not match when method is different' do
      @e.matches?(:bar).should == false
    end
  
    it 'should match when method matches and args are unspecified' do
      @e.matches?(:foo).should == true
    end
    
    it 'should match when method matches and args match' do
      @e.with(7).matches?(:foo, 7).should == true
    end
    
    it 'should not match when method matches but args do not match' do
      @e.with(7).matches?(:foo, 8).should == false
    end
  
    it 'should not yield by default' do
      @e.yield_container.should == nil
    end
  
    it 'should store yield value' do
      @e.yield(1).yield_container.should == Container.new([1])
    end

    it 'should store multiple yield values' do
      @e.yield(1,2).yield_container.should == Container.new([1,2])
    end
    
    it 'should not return by default' do
      @e.return_container.should == nil
    end
    
    it 'should store return value' do
      @e.return(1).return_container.should == Container.new([1])
    end

    it 'should store multiple return values' do
      @e.return(1,2).return_container.should == Container.new([1,2])
    end
    
    it 'should not raise by default' do
      @e.raiser.should == nil
    end
    
    it 'should store raiser' do
      @e.raise('description').raiser.should.not == nil
    end
    
    it 'should count matches' do
      (1..10).each do |i|
        @e.matches?(:foo)
        @e.count.should == i
      end
    end

    it 'should limit matches when given limit of once' do
      @e.once.should == @e
      @e.matches?(:foo).should == true
      @e.matches?(:foo).should == false
    end  
    
    it 'should limit matches when given limit of twice' do
      @e.twice.should == @e
      2.times { @e.matches?(:foo).should == true }
      @e.matches?(:foo).should == false
    end

    it 'should limit matches' do
      @e.exactly(10).times.should == @e
      10.times { @e.matches?(:foo).should == true }
      @e.matches?(:foo).should == false
    end
    
    it 'should initially indicate that expectation was not matched' do
      @e.should.not.be.matched?
    end
  
    it 'should when no limit specified indicate that the expectation was matched once' do
      @e.matches?(:foo)
      @e.should.be.matched?
    end
    
    it 'should when a limit specified indicate that the expectation was not matched until the is limit reached' do
      @e.twice
      @e.matches?(:foo)
      @e.should.not.be.matched?
    end

    it 'should when a limit specified indicate that the expectation was matched once the is limit reached' do
      @e.twice
      2.times { @e.matches?(:foo) }
      @e.should.be.matched?
    end
  end
end