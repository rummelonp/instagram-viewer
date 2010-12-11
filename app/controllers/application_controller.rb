class ApplicationController < ActionController::Base
  protect_from_forgery

  require 'instagram/cached'

  @tmp_dir ||= ENV['TMPDIR'] || ENV['TMP'] || ENV['TEMP'] || '/tmp'
  @cache_dir = File.join @tmp_dir, 'cache'
  Dir.mkdir(@cache_dir) unless File.exists?(@cache_dir)
  Instagram::Cached::setup @cache_dir, :expires_in => 5.minutes

end
