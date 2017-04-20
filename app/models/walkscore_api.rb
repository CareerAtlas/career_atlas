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
          wsapikey: "5108b6df6ffbdbd8ad43d4a5dc25ee8a",
          transit: 1,
          bike: 1,
          format: "JSON"
        }

      }

    )
  end


end
