class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name,:ticker, presence: true



  @client = nil
  # def self.get_price(ticker)
  #   client = IEX::Api::Client.new(
  #     publishable_token: Rails.application.credentials.iex_client[:sandbox_publishable_token],
  #     secret_token: Rails.application.credentials.iex_client[:sandbox_secret_token],
  #     endpoint: 'https://sandbox.iexapis.com/v1'
  #   )
  #   client.price(ticker)
  # end
  def self.config_iex
    @client = IEX::Api::Client.new(
          publishable_token: Rails.application.credentials.iex_client[:sandbox_publishable_token],
          secret_token: Rails.application.credentials.iex_client[:sandbox_secret_token],
          endpoint: 'https://sandbox.iexapis.com/v1'
        )
  end

  def self.get_iex_stock(ticker)
    client = self.config_iex
    begin
      new(ticker: ticker, name: client.company(ticker).company_name, last_price: client.price(ticker))
    rescue => exception
      nil
    end
  end

  def self.already_exists(ticker)
    find_by(ticker: ticker)
  end

end
