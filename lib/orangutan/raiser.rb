class Orangutan::Raiser
  def initialize args
    @args = args
  end

  def execute
    puts 'RAISING ' + @args.inspect
    raise *@args
  end
end