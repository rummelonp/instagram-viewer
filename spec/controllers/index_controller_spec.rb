require 'spec_helper'

describe IndexController do

  describe 'GET "popular"' do
    context :html, :response do
      before { get :popular }
      subject { response }
      it { should be_success }
    end
    context :atom, :response do
      before { get :popular, format: :atom }
      subject { response }
      it { should be_success }
    end
  end

  describe 'GET "user/982876"' do
    context :html do
      context 'without max id', :response do
        before { get :user, id: '982876' }
        subject { response }
        it { should be_success }
      end
      context 'with max id "9578621"', :response do
        before { get :user, id: '982876', max_id: '9578621' }
        subject { response }
        it { should be_success }
      end
    end
    context :atom, :response do
      before { get :user, id: '982876', format: :atom }
      subject { response }
      it { should be_success }
    end
  end

  describe 'POST "find"' do
    context 'without XMLHttpRequest' do

      context 'with empty url' do
        before { post :find, url: '' }
        describe :response do
          subject { response }
          it { should be_redirect }
          describe :redirect_to do
            subject { URI.parse(response.redirect_url).request_uri }
            it { should be_eql '/' }
          end
        end
        describe :flash, :notice do
          subject { request.session['flash'][:notice] }
          it do
            should be_eql ['Sorry, the user id could not find because of an error.',
                           'Please input instagr.am permalink.',
                           '(example: http://instagr.am/p/hpqA/)'].join('\n')
          end
        end
      end

      context 'with url http://instagr.am/p/hpqA/' do
        before { post :find, url: 'http://instagr.am/p/hpqA/' }
        describe :response do
          subject { response }
          it { should be_redirect }
          describe :redirect_to do
            subject { URI.parse(response.redirect_url).request_uri }
            it { should be_eql '/user/982876' }
          end
        end
      end
    end

    context 'with XMLHttpRequest' do

      context 'with empty url' do
        before { xhr :post, :find, url: '' }
        describe :response, :body do
          subject { response.body }
          it do
            text = ['Sorry, the user id could not find because of an error.',
                    'Please input instagr.am permalink.',
                    '(example: http://instagr.am/p/hpqA/)'].join('\n')
            javascript = "alert('#{text}')"
            should be_eql javascript
          end
        end
      end

      context 'with url http://instagr.am/p/hpqA/' do
        before { xhr :post, :find, url: 'http://instagr.am/p/hpqA/' }
        describe :response, :body do
          subject { response.body }
          it do
            url = '/user/982876'
            javascript = "location.href='#{url}'"
            should be_eql javascript
          end
        end
      end

    end
  end

end
