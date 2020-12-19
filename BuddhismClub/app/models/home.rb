class Home < ApplicationRecord
  belongs_to :user, optional: false
  validates :city, presence: true
  
  # Query and return the weather forecast from the API
  def city_info
    loc_id = query_city_id
    if loc_id
      info = get_forecast(loc_id)
      min_temp = info["Temperature"]["Minimum"]["Value"]
      max_temp = info["Temperature"]["Maximum"]["Value"]
      forecast = info["Day"]["IconPhrase"]
      [forecast, min_temp, max_temp]
    else
      ['ERROR', 'ERROR', 'ERROR']
    end

  end

  private

  # Function that just returns the API key from Accuweather
  def api_key
    "yiPTD7uw8TnG5DfVGVchgN7HkMyCMrAv"
  end

  def query_city_id
    base = "http://dataservice.accuweather.com/locations/v1/cities/search"
    query = "#{base}?apikey=#{api_key}&q=#{self.city}"
    http = HTTP.get(query)
    json = JSON.parse(http)
    if json[0]
      json[0]["Key"]
    end
  end

  def get_forecast(loc_id)
    base = "http://dataservice.accuweather.com/forecasts/v1/daily/1day/"
    query = "#{base}#{loc_id}?apikey=#{api_key}"
    http = HTTP.get(query)
    json = JSON.parse(http)
    json["DailyForecasts"][0]
  end
end
