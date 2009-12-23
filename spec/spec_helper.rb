require 'orangutan/mock_adapter'
require 'ClassLibrary.dll'

Spec::Runner.configure do |config|
  # turn off mocking
  config.mock_with Orangutan::MockAdapter
end