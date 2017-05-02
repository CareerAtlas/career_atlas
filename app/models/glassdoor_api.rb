class GlassdoorApi
  include HTTParty

  def self.search_company(search_params)
    HTTParty.get("http://api.glassdoor.com/api/api.htm?",
      {
        query:
        {
          v: 1,
          format: "json",
          "t.p": ENV["GLASSDOORID"],
          "t.k": ENV["GLASSDOORAPIKEY"],
          action: "employers",
          q: search_params["company"]
        }
      }
    )
  end
end
