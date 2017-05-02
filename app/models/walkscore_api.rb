class WalkscoreApi
  include HTTParty

  def self.search_walkscore(search_params)


    results = get("http://api.walkscore.com/score?",
      {
        query:
        {
          lat: search_params["latitude"],
          lon: search_params["longitude"],
          wsapikey: ENV["WALKSCOREAPIKEY"],
          format: "json"
        }

      }

    )

    results
  end


end
