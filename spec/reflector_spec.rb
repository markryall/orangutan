require File.dirname(__FILE__) + '/spec_helper'

if ENV['CLR']
module Orangutan
  describe Reflector do
    it 'should find methods on an interface' do
      Reflector.new(ClassLibrary::IHaveAMethod).methods.should == [:my_method]
    end

    it 'should find properties on an interface' do
      Reflector.new(ClassLibrary::IHaveAProperty).properties.should == [:my_property]
    end

    it 'should find events on an interface' do
      Reflector.new(ClassLibrary::IHaveAnEvent).events.should == ['MyEvent']
    end
  end
end
end