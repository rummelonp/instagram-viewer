class IndexController < ApplicationController

  def index
    @photos = Instagram::popular
  end

  def user
    id = params.delete :id
    @photos = Instagram::by_user id, params
    @photo = @photos.last
  end

end
