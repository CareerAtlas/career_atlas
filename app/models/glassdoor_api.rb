class GlassdoorApi

  def self.search_company(ipaddress, browser, company)
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
          q: company
        }
      }
    )
  end
end
