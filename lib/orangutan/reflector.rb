class Orangutan::Reflector
  def initialize type
    @type = type.to_clr_type
  end

  def methods
    @type.get_methods.map { |info| snake info.name }
  end

  def properties
    @type.get_properties.map { |info| snake info.name }
  end

  def events
    @type.get_events.map { |info| info.name }
  end

  def snake text
    text.scan(/[A-Z][a-z0-9]*/).map {|a|a.downcase}.join('_').to_sym
  end
end
