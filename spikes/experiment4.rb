#demonstrates interaction with a moq instance

require 'consumer'
require 'Moq.3.0.308.2\Moq.dll'

mock = Moq::Mock.of(ClassLibrary::IConsumable).new
# i hoped to be able to use this (hoping divine intervention would turn the proc into a linq expression):
m = Proc.new { |o| o.consume('foo') }
# but then (in desperation) tried to use this freaky weirdness:
c = ClassLibrary::ClosureFactory.create_consume_caller('foo')
mock.setup(c).returns(true)
consumer.consume(mock.object)
mock.verify_all
