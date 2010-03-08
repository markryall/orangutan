require 'orangutan/chantek'

module Orangutan
  module MockAdapter
    def setup_mocks_for_rspec
      self.class.class_eval {include Orangutan::Chantek}
      reset_stubs
    end

    def verify_mocks_for_rspec
    end

    def teardown_mocks_for_rspec
      restore_methods
    end
  end
end

Spec::Runner.configure do |config|
  # turn off mocking
  config.mock_with Orangutan::MockAdapter
end