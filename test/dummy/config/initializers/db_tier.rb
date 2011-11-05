ActionController::Base.class_eval do
  include DbTier
end

test_config = {:adapter  => "sqlite3",
               :database => "/home/fernando/src/db_tier/test/dummy/db/test.sqlite3", 
               :pool     => 1,
               :timeout  => 1000}

#DbTier::Config.init(test_config)

 DbTier::Config.init do
   params = DbTier::Config.locals[:request].params
    
   Rails.logger.debug("\nUser code called with params: #{params.inspect}\n")
   if params["db"]
     param_db = File.join(RAILS_ROOT,"db/#{params["db"]}.sqlite3")
     test_config.merge!(:database => param_db) 
     Rails.logger.debug("\t received #{params}---------\n\n")
   else
     Rails.logger.debug("\t default---------\n\n")
   end
   test_config
 end
