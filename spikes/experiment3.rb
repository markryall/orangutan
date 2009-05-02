# demonstrates interaction with an nmock instance

require 'consumer'
require 'mocks\nmock2-2.0.0.44-net-2.0\bin\NMock2.dll'

mockery = NMock2::Mockery.new
mock_consumable = mockery.new_mock(ClassLibrary::IConsumable.to_clr_type)
puts 'setting expectation'
NMock2::Expect.once.on(mock_consumable).method('Consume')
puts 'calling consume'
$consumer.consume(mock_consumable)
puts 'verify'
mockery.verify_all_expectations_have_been_met
