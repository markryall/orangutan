require File.dirname(__FILE__) + '/spec_helper'

describe Orangutan::Chantek, 'creating clr stubs' do
  before do
    @orangutan = Orangutan::Chantek.new
  end

  it 'should create stub implementations of a clr interface with a method' do
    s = @orangutan.stub(:foo, :clr_interface => ClassLibrary::IHaveAMethod)
    @orangutan.when(:foo).receives(:my_method).return(false)
    c = ClassLibrary::Consumer.new
    c.call_method(s) 
    @orangutan.calls[0].should == Orangutan::Call.new(:foo, :my_method, ['thing'])
  end

  it 'should create stub implementations of a clr interface with a property'

  it 'should create stub implementations of a clr interface with an event' do
    stub = @orangutan.stub(:foo, :clr_interface => ClassLibrary::IHaveAnEvent)
    consumer = ClassLibrary::Consumer.new
    consumer.register_event(stub)

    @orangutan.fire_event :foo, 'MyEvent', stub, System::EventArgs.new
    @orangutan.calls[1].should == Orangutan::Call.new(:foo, :my_method, ['thing'])
  end
end