class IndeedApi < ApplicationRecord

  def search_jobs(word_search, location, job_type, user_ip, user_browser)
    HTTParty.get("http://api.indeed.com/ads/apisearch?",
      {
        params: [
          {publisher: 8417063092021675},
          {format: "json"},
          {q: word_search},
          {l: location},
          {st: "jobsite"},
          {jt: tob_type},
          {limit: 50},
          {fromage: "any"},
          {highlight: 1},
          {latlong: 1},
          {userip: user_ip},
          {useragent: user_browser},
          {v: 2}
        ].to_json
      }
    )
  end
end
