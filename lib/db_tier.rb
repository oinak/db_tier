
module DbTier

  def self.included(base)
    base.extend(ClassMethods)
  end

  class Config

    def self.init(config_hash=nil, &block)
      @@config_hash = config_hash
      @@config_method = block if block_given?
    end

    def self.retrieve
      @@config_hash || @@config_method.call
    end

    class<<self
      attr_accessor :locals
      attr_accessor :config_hash
      attr_accessor :config_method
    end

  end

  module ClassMethods
    def acts_as_db_tier

      before_filter :tiered_connection

      include DbTier::InstanceMethods
    end

    # Make the @db_tier_config class variable easily
    # accessable from the instance methods.
    def db_tier_config
      @db_tier_config || self.superclass.instance_variable_get('@db_tier_config')
    end
  end

  module InstanceMethods
    def tiered_connection
      DbTier::Config.locals = {:request => request, :session => session}
      @db_tier_config = DbTier::Config.retrieve
      ActiveRecord::Base.establish_connection( @db_tier_config )
    end
  end

end
