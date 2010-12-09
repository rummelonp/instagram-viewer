class IndexController < ApplicationController

  def index
    @photos = Instagram::popular
  end

  def user
    @photos = Instagram::by_user params[:id]
  end

end
