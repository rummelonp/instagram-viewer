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
    @user   = Instagram::Cached::user_info id
    @title  = "Photos by #{@user.username}"

    respond_to do |format|
      format.html
      format.atom do
        @popular = false
        render :action => 'photos.atom.builder'
      end
    end
  end

  def find
    return redirect_to "/" unless params[:url] =~ %r{http://instagr.am/p/[\w\d]+/}

    url = Addressable::URI.parse params[:url]
    if Instagram::Cached::send(:get_url, url) =~ %r{profiles/profile_(\d+)_}
      redirect_to "/user/#{$1}"
    else
      redirect_to "/"
    end
  end

end
