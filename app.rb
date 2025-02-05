require "sinatra"
require "sinatra/reloader"


get("/") do
  currency_url= "https://api.exchangerate.host/list?access_key="+ exch_key
  raw_currency_response= HTTP.get(currency_url)
  parse_currency=JSON.parse(raw_currency)
  currency = parse_currency.dig("success", "terms", "privacy", "currencies")
  pp currency
erb(:homepage)
end
