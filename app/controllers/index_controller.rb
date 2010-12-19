class IndexController < ApplicationController

  def popular
    cached_setup :expires_in => 15.minutes
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
    cached_setup :expires_in => 1.hour
    @photos = Instagram::Cached::by_user id, params
    cached_setup :expires_in => 2.hour
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
        text = ['Sorry, the user id could not find on this page.',
                'Can not find user if user does not setting icon.'].join('\n')
        if request.xhr?
          render :text => "alert('#{text}')"
        else
          flash[:notice] = text
          redirect_to '/'
        end
      end
    rescue
      text = ['Sorry, the user id could not find because of an error.',
              'Please input instagr.am permalink.',
              '(example: http://instagr.am/p/hpqA/)'].join('\n')
      if request.xhr?
        render :text => "alert('#{text}')"
      else
        flash[:notice] = text
        redirect_to '/'
      end
    end
  end

end
