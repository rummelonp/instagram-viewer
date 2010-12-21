require 'spec_helper'

describe :routes do

  describe :popular do
    subject { {get: '/popular'} }
    it { should route_to(controller: 'index', action: 'popular') }
  end

  describe :popular, :atom do
    subject { {get: '/popular.atom'} }
    it { should route_to(controller: 'index', action: 'popular', format: 'atom') }
  end

  describe :user do
    subject { {get: '/user/982876'} }
    it { should route_to(controller: 'index', action: 'user', id: '982876') }
  end

  describe :user, :atom do
    subject { {get: '/user/982876.atom'} }
    it { should route_to(controller: 'index', action: 'user', id: '982876', format: 'atom') }
  end

  describe :find do
    subject { {post: '/find', url: ''} }
    it { should route_to(controller: 'index', action: 'find') }
  end

end
