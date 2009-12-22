require File.dirname(__FILE__) + '/spec_helper'

describe Orangutan::Chantek, 'creating clr stubs' do
  before do
    @orangutan = Orangutan::Chantek.new
    @consumer = ClassLibrary::Consumer.new
  end

  it 'should create stub implementations of a clr interface with a method' do
    stub = @orangutan.stub(:foo, :clr_interface => ClassLibrary::IHaveAMethod)
    @orangutan.when(:foo).receives(:my_method).return(false)

    @consumer.call_method(stub) 

    @orangutan.calls[0].should == Orangutan::Call.new(:foo, :my_method, ['thing'])
  end

  it 'should create stub implementations of a clr interface with a setter and getter' do
    foo = @orangutan.stub(:foo, :clr_interface => ClassLibrary::IHaveAProperty)
    @orangutan.when(:foo).receives(:my_property).return('this')
    
    @consumer.call_getter(foo)
    @consumer.call_setter(foo)

    @orangutan.calls.should == [
      Orangutan::Call.new(:foo, :my_property, []),
      Orangutan::Call.new(:foo, :MyProperty=, ['this'])
    ]
  end

  it 'should create stub implementations of a clr interface with an event' do
    stub = @orangutan.stub(:foo, :clr_interface => ClassLibrary::IHaveAnEvent)
    @orangutan.when(:foo).receives(:my_method).return(false)
    consumer = ClassLibrary::Consumer.new
    consumer.register_event(stub)

    @orangutan.fire_event :foo, 'MyEvent', stub, System::EventArgs.new

    @orangutan.calls.should == [
      Orangutan::Call.new(:foo, :add_MyEvent, []),
      Orangutan::Call.new(:foo, :my_method, ['thing'])
    ]
  end
end