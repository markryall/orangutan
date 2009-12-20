module NoMocksAdapter
  def setup_mocks_for_rspec
  end

  def verify_mocks_for_rspec
  end

  def teardown_mocks_for_rspec
  end
end

Spec::Runner.configure do |config|
  # turn off mocking
  config.mock_with NoMocksAdapter
end

require 'orangutan'
require 'ClassLibrary.dll'