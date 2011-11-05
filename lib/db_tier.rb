module DbTier
  # intercept ActiveRecord#establish_connection intended config to make it use our params

  # instantiate in you initializer to define config retrieving method
  class Config
    def self.init(config_hash=nil, &block)
      @config_hash = config_hash
      @config_method = block if block_given?

      ApplicationController.instance_eval do

        protected

        def db_tier_select
          raise 'ey'
          # Establish the request specific connection
          ActiveRecord::Base.establish_connection( DbTier::Config.retrieve )
        end

        public
        before_filter :db_tier_select
      end
    end

    def self.retrieve
      @config_hash || @config_method.call
    end
  end
end
