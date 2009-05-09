require 'orangutan'
require 'ClassLibrary.dll'

describe Orangutan::Chantek, 'creating clr stubs' do
  it 'should create stub implementations of a clr interface with a method' do
    o = Orangutan::Chantek.new
    s = o.stub :foo, :clr_interface => ClassLibrary::IHaveAMethod
    c = ClassLibrary::Consumer.new
    c.call_method(s) 
    o.calls[0].should == Orangutan::Call.new(:foo, :my_method, ['thing'])
  end
end