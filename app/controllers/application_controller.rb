class ApplicationController < ActionController::Base
  protect_from_forgery

  Instagram::Cached::setup RAILS_CACHE.cache_path, :expires_in => 10.minutes

end
