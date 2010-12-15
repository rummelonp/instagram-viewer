require 'spec_helper'

describe IndexController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'user'" do
    it "should be successful" do
      get 'user'
      response.should be_success
    end
  end

  describe "GET 'find'" do
    it "should be successful" do
      get 'find'
      response.should be_success
    end
  end

end
