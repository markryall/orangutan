class Orangutan::Raiser
  def initialize args
    @args = args
  end

  def execute
    raise *@args
  end
end