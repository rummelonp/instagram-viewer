class IndexController < ApplicationController

  def index
    @photos = Instagram::Cached::popular
  end

  def user
    id = params.delete :id
    @photos = Instagram::Cached::by_user id, params
    @photo = @photos.last
  end

end
