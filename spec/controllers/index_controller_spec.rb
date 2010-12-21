require 'spec_helper'

describe IndexController do

  describe 'GET "popular"' do
    context :html do
      before { get :popular }
      describe :response do
        subject { response }
        it { should be_success }
      end
    end
    context :atom do
      before { get :popular, format: :atom }
      describe :response do
        subject { response }
        it { should be_success }
      end
    end
  end

  describe 'GET "user/982876"' do
    context :html do
      context 'without_max_id' do
        before { get :user, id: '982876' }
        describe :response do
          subject { response }
          it { should be_success }
        end
      end
      context 'with_max_id "9578621"' do
        before { get :user, id: '982876', max_id: '9578621' }
        describe :response do
          subject { response }
          it { should be_success }
        end
      end
    end
    context :atom do
      before { get :user, id: '982876', format: :atom }
      describe :response do
        subject { response }
        it { should be_success }
      end
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
        describe :flash do
          describe :notice do
            subject { request.session['flash'][:notice] }
            it do
              should be_eql ['Sorry, the user id could not find because of an error.',
                             'Please input instagr.am permalink.',
                             '(example: http://instagr.am/p/hpqA/)'].join('\n')
            end
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
        describe :response do
          describe :body do
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
      end

      context 'with url http://instagr.am/p/hpqA/' do
        before { xhr :post, :find, url: 'http://instagr.am/p/hpqA/' }
        describe :response do
          describe :body do
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

end
