class ApplicationController < ActionController::Base
  protect_from_forgery

  Instagram::Cached::setup RAILS_CACHE.cache_path, :expires_in => 10.minutes

  def discover_user_id(url)
    url = Addressable::URI.parse url unless url.respond_to? :host
    $1.to_i if Instagram::Cached::send(:get_url, url) =~ %r{profiles/profile_(\d+)_}
  end

end
