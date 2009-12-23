require File.dirname(__FILE__) + '/spec_helper'

describe 'creating clr stubs' do
  before do
    @consumer = ClassLibrary::Consumer.new
  end

  it 'should create stub implementations of a clr interface with a method' do
    foo = stub(:foo, :clr_interface => ClassLibrary::IHaveAMethod)
    so_when(:foo).receives(:my_method).return(false)

    @consumer.call_method(foo) 

    calls.should == [call(:foo, :my_method, 'thing')]
  end

  it 'should create stub implementations of a clr interface with a setter and getter' do
    foo = stub(:foo, :clr_interface => ClassLibrary::IHaveAProperty)
    so_when(:foo).receives(:my_property).return('this')
    
    @consumer.call_getter(foo)
    @consumer.call_setter(foo)

    calls.should == [
      call(:foo, :my_property),
      call(:foo, :MyProperty=, 'this')
    ]
  end

  it 'should create stub implementations of a clr interface with an event' do
    foo = stub(:foo, :clr_interface => ClassLibrary::IHaveAnEvent)
    so_when(:foo).receives(:my_method).return(false)
    consumer = ClassLibrary::Consumer.new
    consumer.register_event(foo)

    fire_event :foo, 'MyEvent', foo, System::EventArgs.new

    calls.should == [
      call(:foo, :add_MyEvent),
      call(:foo, :my_method, 'thing')
    ]
  end
end