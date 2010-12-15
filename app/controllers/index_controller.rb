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
    begin
      id = discover_user_id(params[:url])
      if id
        url = "/user/#{id}"
        if request.xhr?
          render :text => "location.href='#{url}'"
        else
          redirect_to url
        end
      else
        text  = 'Sorry, the user id could not find on this page.\n'
        text += 'Can not find user if user does not setting icon.'
        if request.xhr?
          render :text => "alert('#{text}')"
        else
          flash[:notice] = text
          redirect_to '/'
        end
      end
    rescue
      text  = 'Sorry, the user id could not find because of an error.\n'
      text += 'Please input instagr.am permalink.\n'
      text += '(example: http://instagr.am/p/hpqA/)'
      if request.xhr?
        render :text => "alert('#{text}')"
      else
        flash[:notice] = text
        redirect_to '/'
      end
    end
  end

end
