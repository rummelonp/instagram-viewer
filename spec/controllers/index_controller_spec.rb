require 'spec_helper'

describe IndexController do

  describe 'GET "popular"' do
    before { get :popular }
    describe :routes do
      subject { {:get => '/popular'} }
      it { should route_to(controller: 'index', action: 'popular') }
    end
    describe :response do
      subject { response }
      it { should be_success }
    end
  end

  describe 'GET "popular.atom"' do
    before { get :popular, format: :atom }
    describe :routes do
      subject { {:get => '/popular.atom'} }
      it { should route_to(controller: 'index', action: 'popular', format: 'atom') }
    end
    describe :response do
      subject { response }
      it { should be_success }
    end
  end

  describe 'GET "user/982876"' do
    before { get :user, id: 982876 }
    describe :routes do
      subject { {:get => '/user/982876'} }
      it { should route_to(controller: 'index', action: 'user', id: '982876') }
    end
    describe :response do
      subject { response }
      it { should be_success }
    end
  end

  describe 'GET "user/982876.atom"' do
    before { get :user, id: 982876, format: :atom }
    describe :routes do
      subject { {:get => '/user/982876.atom'} }
      it { should route_to(controller: 'index', action: 'user', id: '982876', format: 'atom') }
    end
    describe :response do
      subject { response }
      it { should be_success }
    end
  end

  describe 'POST "find"' do
    before { post :find }
    describe :routes do
      subject { {:post => '/find'} }
      it { should route_to(controller: 'index', action: 'find') }
    end
    describe :response do
      subject { response }
      it { should be_redirect }
      it 'redirect_url should be "/"' do
        URI.parse(response.redirect_url).request_uri.should == '/'
      end
    end
  end

end
