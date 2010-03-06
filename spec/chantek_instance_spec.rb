require File.dirname(__FILE__) + '/spec_helper'

describe 'creating ruby method stubs' do
  describe 'for an instance' do
    before do
      @foo = Object.new
      @foo_id = @foo.object_id
      register_object :foo, @foo
      stub_method :foo, :object_id
    end
  
    it 'should allow instance methods to be stubbed' do
      so_when(:foo).receives(:object_id).return('YOWZAA!!')
      @foo.object_id.should == 'YOWZAA!!'
      calls.should == [call(:foo, :object_id)]
    end
  
    it 'should allow instance method stubs to be restored' do
      restore_method :foo, :object_id
      @foo.object_id.should == @foo_id
      calls.should == []
    end
  end
  
  describe 'for a class' do
    it 'should allow instance methods to be stubbed' do
      register_object :math, Math
      stub_method :math, :cos
      so_when(:math).receives(:cos).with(0).return('WHO KNOWS!!')
      Math.cos(0).should == 'WHO KNOWS!!'
      calls.should == [call(:math, :cos, 0)]
    end
    
    it 'should restore methods automatically' do
      Math.cos(0).should == 1.0
    end
  end
end