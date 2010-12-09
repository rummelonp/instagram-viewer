class IndexController < ApplicationController

  def index
    @photos = Instagram::popular
  end

  def user
  end

end
