require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
exch_key = ENV.fetch("CURRENCY_KEY")

get("/") do
  currency_url= "https://api.exchangerate.host/list?access_key="+ exch_key
  @raw_currency_response= HTTP.get(currency_url).to_s
  @parse_currency=JSON.parse(@raw_currency_response)
  @currency_array = @parse_currency.fetch("currencies")
  @currency_hash = {
    abrev: @currency_array.keys,
    currency: @currency_array.values
  }

erb(:homepage)
end

get("/:abrev")do
@orginal_currency=params.fetch("abrev")
api_url= "https://api.exchangerate.host/list?access_key="+exch_key

end
