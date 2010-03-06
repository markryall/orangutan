require File.dirname(__FILE__) + '/spec_helper'

describe 'creating ruby method stubs' do
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