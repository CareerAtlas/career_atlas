class WalkscoreApi
  include HTTParty

  def self.search_walkscore(search_params)
    HTTParty.get("http://api.walkscore.com/score?",
      {
        query:
        {
          lat: search_params["latitude"],
          lon: search_params["longitude"],
          address: search_params["address"],
          wsapikey: ENV["WALKSCOREAPIKEY"],
          transit: 1,
          bike: 1,
          format: "json"
        }

      }

    )
  end


end
