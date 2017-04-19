class GlassdoorApi
  include HTTParty

  def self.search_company(search_params)
    HTTParty.get("http://api.glassdoor.com/api/api.htm?",
      {
        query:
        {
          v: 1,
          format: "json",
          "t.p": 142249,
          "t.k": "kHfjVZZplCE",
          userip: ipaddress,
          useragent: browser,
          action: "employers",
          q: search_company["company"]
        }
      }
    )
  end
end
