require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
exch_key = ENV.fetch("CURRENCY_KEY")

get("/") do
  currency_url= "https://api.exchangerate.host/list?access_key="+ exch_key
  @raw_currency_response= HTTP.get(currency_url).to_s
  @parse_currency=JSON.parse(@raw_currency_response)
  @currency_array = @parse_currency.fetch("currencies").keys

erb(:homepage)
end

get("/:from_abrev")do
@original_currency=params.fetch("from_abrev")
api_url= "https://api.exchangerate.host/list?access_key="+exch_key
@raw_currency_response= HTTP.get(api_url).to_s
@parse_currency=JSON.parse(@raw_currency_response)
@currency_array = @parse_currency.fetch("currencies")
@currency = @currency_array.keys

erb(:from_abrev)
end

get("/:from_abrev/:to_abrev")do
@original_currency=params.fetch("from_abrev")
@destination_currency=params.fetch("to_abrev")
exchange_url= "https://api.exchangerate.host/convert?access_key=" +exch_key +"&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
@raw_currency_response= HTTP.get(exchange_url).to_s
@parse_currency=JSON.parse(@raw_currency_response)
@currency_array = @parse_currency.fetch("quotes")
@quote = @parse_currency.fetch(@destination_currency)
erb(:to_abrev)
end
