module DbTier
  # intercept ActiveRecord#establish_connection intended config to make it use our params

  # instantiate in you initializer to define config retrieving method
  class Config

    def self.init(config_hash=nil, &block)
      @config_hash = config_hash
      @config_method = block if block_given?

      # Simpler version:
      ApplicationController.before_filter Proc.new {
        DbTier::Config.locals= {:request => request, :session => session}
        ActiveRecord::Base.establish_connection(DbTier::Config.retrieve)
      }

    end

    def self.locals=(par)
      @@locals = par
    end

    def self.locals
      @@locals
    end

    def self.retrieve
      @config_hash || @config_method.call
    end

  end
end
