require 'expectation'

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
end
