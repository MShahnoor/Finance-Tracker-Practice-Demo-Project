class Stock < ApplicationRecord

  @client = nil
  # def self.get_price(ticker)
  #   client = IEX::Api::Client.new(
  #     publishable_token: Rails.application.credentials.iex_client[:sandbox_publishable_token],
  #     secret_token: Rails.application.credentials.iex_client[:sandbox_secret_token],
  #     endpoint: 'https://sandbox.iexapis.com/v1'
  #   )
  #   client.price(ticker)
  # end
  def self.config_ief
    @client = IEX::Api::Client.new(
          publishable_token: Rails.application.credentials.iex_client[:sandbox_publishable_token],
          secret_token: Rails.application.credentials.iex_client[:sandbox_secret_token],
          endpoint: 'https://sandbox.iexapis.com/v1'
        )
  end

  def self.get_price(ticker)
    client = self.config_ief
    client.price(ticker)
  end
end
