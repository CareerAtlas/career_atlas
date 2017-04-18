class IndeedApi
  include HTTParty

  def self.search_jobs(search_params)
    get("http://api.indeed.com/ads/apisearch?",
      {
        query:
          {
          publisher: 8417063092021675,
          format: "json",
          q: search_params["job_title"],
          l: search_params["location"],
          radius: search_params["radius"],
          st: "jobsite",
          jt: search_params["job_type"],
          limit: 50,
          fromage: "any",
          highlight: 1,
          latlong: 1,
          # userip: user_ip,
          # useragent: user_browser,
          v: 2
          }
      }
    )
  end
end
