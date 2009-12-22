# demonstrates interaction with an actual class instance

require 'consumer'

class ClassWithMethod
  include ClassLibrary::IHaveAMethod

  def my_method name
    puts 'ruby method invoked with ' + name
    true
  end
end

class ClassWithOverridenMethod < ClassLibrary::ClassWithAVirtualMethod
  def my_method name
    puts 'ruby method method invoked with ' + name
    true
  end
end

class ClassWithPotentiallyOverridenMethod < ClassLibrary::ClassWithANonVirtualMethod
  def my_method name
    puts 'ruby method invoked with ' + name
    true
  end
end

class ClassWithProperty
  include ClassLibrary::IHaveAProperty

  def my_property
    puts 'ruby getter was called'
    @prop
  end

  def my_property= v
    puts 'ruby setter was called with ' + v
    @prop = v
  end
end

class ClassWithOverridenProperty < ClassLibrary::ClassWithAVirtualProperty
  def my_property
    puts 'ruby getter was called'
    @prop
  end

  def my_property= v
    puts 'ruby setter was called with ' + v
    @prop = v
  end
end

class ClassWithPotentiallyOverridenProperty < ClassLibrary::ClassWithANonVirtualProperty
  def my_property
    puts 'ruby getter was called'
    @prop
  end

  def my_property= v
    puts 'ruby setter was called with ' + v
    @prop = v
  end
end


class ClassWithEvent
  include ClassLibrary::IHaveAnEvent

  def initialize
    @delegates = []
  end

  def add_MyEvent delegate
    @delegates << delegate
  end

  def my_method name
    puts 'ruby method invoked with ' + name
    true
  end

  def fire_event
    @delegates.each {|delegate| delegate.invoke(self, System::EventArgs.new)}
  end
end

[ClassWithMethod, ClassWithOverridenMethod, ClassWithPotentiallyOverridenMethod].each do |c|
  puts 'trying ' + c.to_s
  $consumer.call_method(c.new)
end

[ClassWithProperty, ClassWithOverridenProperty, ClassWithPotentiallyOverridenProperty].each do |c|
  puts 'trying ' + c.to_s
  c2 = ClassWithProperty.new
  $consumer.call_setter(c2)
  $consumer.call_getter(c2)
  $consumer.call_setter(c2)
  $consumer.call_getter(c2)
end

puts 'trying ClassWithEvent'
c3 = ClassWithEvent.new
$consumer.register_event(c3)
c3.fire_event
c3.fire_event