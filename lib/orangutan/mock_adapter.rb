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
    end
  end
end