class WalkscoreApi
  include HTTParty

  def self.search_walkscore(search_params)


    results = get("http://api.walkscore.com/score?",
      {
        query:
        {
          lat: search_params["latitude"],
          lon: search_params["longitude"],
          wsapikey: "5108b6df6ffbdbd8ad43d4a5dc25ee8a",
          transit: 1,
          bike: 1,
          format: "json"
        }

      }

    )

    results
  end


end
