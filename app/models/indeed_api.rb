class IndeedApi
  include HTTParty

  def self.search_jobs(search_params)
    get("http://api.indeed.com/ads/apisearch?",
      {
        query:
        {
          publisher: ENV["INDEEDAPIKEY"],
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
          v: 2
        }
      }
    )
  end

  def self.search_for_job(search_param)
        get("http://api.indeed.com/ads/apigetjobs?",
      {
        query:
        {
          publisher: ENV["INDEEDAPIKEY"],
          jobkeys: search_param,
          v: 2,
          format: "json"
        }
      }
    )
  end
end
