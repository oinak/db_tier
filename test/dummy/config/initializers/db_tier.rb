test_config = {:adapter=>"sqlite3", :database=>"/home/fernando/src/db_tier/test/dummy/db/development.sqlite3", :pool=>5, :timeout=>5000}

# DbTier::Config.init(test_config)

 DbTier::Config.init do
   params = DbTier::Config.locals[:request].params
   test_config.merge(:database => params[:db]) if params[:db]
   test_config
 end
