require 'pp'

class IndexController < ApplicationController
    attr_reader :token
    #ページ読み込み
    def home
        @token = Token.new
        @token.create_token
        cookies['access-token'] = @token.client.access_token
        cookies['access-token-secret'] = @token.client.access_token_secret
        @home_timeline = @token.home_timeline
        render "index/home"
    end

    #ログイン
    def login
        @token = Token.new
        cookies["token"] = @token
        home
    end

    def create_status
      @token = Token.new
      @token.create_token_from_access_tokens(cookies['access-token'], cookies['access-token-secret'])
      @token.create_status(params[:text])
      home
    end
end
