# demonstrates interaction with an actual class instance

require 'consumer'

class AConsumable
  include ClassLibrary::IConsumable

  def consume name
    puts 'i consumed ' + name
  end
end

consumable = AConsumable.new
$consumer.consume(consumable)
