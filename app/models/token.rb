require 'twitter'
require 'pp'

ENV["SSL_CERT_FILE"] = Rails.application.secrets.ssl_cert_file

class Token
    include ActiveModel::Model
    
    attr_reader :user
    attr_reader :client

    def create_token
        create_token_from_access_tokens(Rails.application.secrets.access_token, Rails.application.secrets.access_token_secret)
    end

    def create_token_from_access_tokens(access_token, access_token_secret)
        @client = Twitter::REST::Client.new do |config|
            config.consumer_key = Rails.application.secrets.consumer_key
            config.consumer_secret = Rails.application.secrets.consumer_secret
            config.access_token = access_token
            config.access_token_secret = access_token_secret
        end
        verify
    end

    def home_timeline
      begin
        return @client.home_timeline(count: 100)
      rescue => e
        return nil
      end
    end

    #認証
    def verify
        @user = @client.verify_credentials()
    end

    #ツイート作成
    def create_status(text)
        @client.update(text)
    end
end
