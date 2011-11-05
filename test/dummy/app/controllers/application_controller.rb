class ApplicationController < ActionController::Base
  protect_from_forgery
=begin
  protected

  # The following code must be injected from the gem:
  def db_tier_select
    # Establish the request specific connection
    ActiveRecord::Base.establish_connection( DbTier::Config.retrieve )
  end

  public
  before_filter :db_tier_select
=end

  acts_as_db_tier

end

