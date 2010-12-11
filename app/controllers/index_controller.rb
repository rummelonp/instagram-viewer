class IndexController < ApplicationController

  def index
    @photos = Instagram::Cached::popular
    @title  = "Popular Photos"

    respond_to do |format|
      format.html
      format.atom do
        @popular = true
        render :action => 'photos.atom.builder'
      end
    end
  end

  def user
    id = params.delete :id
    @photos = Instagram::Cached::by_user id, params
    @title  = "Photos by #{@photos.first.user.username}"

    respond_to do |format|
      format.html
      format.atom do
        @popular = false
        render :action => 'photos.atom.builder'
      end
    end
  end

end
