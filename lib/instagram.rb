# -*- coding: utf-8 -*-
#
# MIT-LICENSE
#
# Copyright (c) 2010 Mislav Marohnić
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#
# Credits
#
# Instagram API reverse-engineered and Ruby library written by Mislav Marohnić.
#
# [instagram]: http://instagr.am/
# [wiki]: https://github.com/mislav/instagram/wiki "Instagram API"
#

require 'addressable/uri'
require 'addressable/template'
require 'instagram/models'
require 'instagram/failsafe_store'
require 'instagram/cached'

module Instagram

  extend self

  Popular = Addressable::URI.parse 'http://instagr.am/api/v1/feed/popular/'
  UserFeed = Addressable::Template.new 'http://instagr.am/api/v1/feed/user/{user_id}/'
  UserInfo = Addressable::Template.new 'http://instagr.am/api/v1/users/{user_id}/info/'

  def popular(params = {}, options = {})
    parse_response(Popular.dup, params, options.fetch(:parse_with, Timeline))
  end

  def by_user(user_id, params = {}, options = {})
    url = UserFeed.expand :user_id => user_id
    parse_response(url, params, options.fetch(:parse_with, Timeline))
  end

  def user_info(user_id, params = {}, options = {})
    url = UserInfo.expand :user_id => user_id
    parse_response(url, params, options.fetch(:parse_with, UserWrap))
  end

  private

  def parse_response(url, params, parser = nil)
    url.query_values = params
    body = get_url url
    parser ? parser.parse(body) : body
  end

  def get_url(url)
    response = Net::HTTP.start(url.host, url.port) do |http|
      http.get url.request_uri
    end

    if Net::HTTPSuccess === response
      response.body
    else
      response.error!
    end
  end

end
