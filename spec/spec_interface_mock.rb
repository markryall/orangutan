require 'oranutan'

describe Orangutan do
  before do
    @o = Orangutan.new
  end

  it 'should record method calls on a stub' do
    s = @o.stub 'foo'
    s.method1(1,2,3)
    s.calls[0].should == Orangutan::Call('foo', :method1, [1,2,3])
  end
end
