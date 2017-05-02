class IndeedApi
  include HTTParty

  def self.search_jobs(search_params)
    jobs = get("http://api.indeed.com/ads/apisearch?",
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
          v: 2,
          userip: search_params["ipaddress"],
          useragent: search_params["browser"]
        }
      }
    )
    format_jobs(jobs["results"])
  end

  def self.find_job(search_param)
        job_result = get("http://api.indeed.com/ads/apigetjobs?",
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
    job = job_result["results"]&.first
    if job
      format_job(job)
    end
  end

  def self.format_jobs(jobs)
    jobs.map do |job|
      format_job(job)
    end
  end

  def self.format_job(job)
    {
      job_title: job["jobtitle"],
      company: job["company"],
      url: job["url"],
      latitude: job["latitude"],
      longitude: job["longitude"],
      job_key: job["jobkey"],
      location: job["formattedLocationFull"],
      date_posted: job["formattedRelativeTime"]
    }
  end
end
