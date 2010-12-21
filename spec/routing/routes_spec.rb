require 'spec_helper'

describe :routes do

  describe 'GET "popular"' do
    context :html do
      subject { {get: '/popular'} }
      it { should route_to(controller: 'index', action: 'popular') }
    end
    context :atom do
      subject { {get: '/popular.atom'} }
      it { should route_to(controller: 'index', action: 'popular', format: 'atom') }
    end
  end

  describe 'GET "user/982876"' do
    context :html do
      context 'without max id' do
        subject { {get: '/user/982876'} }
        it { should route_to(controller: 'index', action: 'user', id: '982876') }
      end
      context 'with max id "9578621"' do
        subject { {get: '/user/982876/max_id/9578621'} }
        it { should route_to(controller: 'index', action: 'user', id: '982876', max_id: '9578621') }
      end
    end

    context :atom do
      subject { {get: '/user/982876.atom'} }
      it { should route_to(controller: 'index', action: 'user', id: '982876', format: 'atom') }
    end
  end

  describe 'POST "find"' do
    subject { {post: '/find', url: ''} }
    it { should route_to(controller: 'index', action: 'find') }
  end

end
