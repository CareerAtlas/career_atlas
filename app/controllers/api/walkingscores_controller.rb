class Api::WalkingscoresController < ApplicationController

  def index
    walk_score = WalkscoreApi.search_walkscore(params)
    walk_score_info = output(walk_score)
    render json: walk_score_info
  end

  private
  
  def output(search)
    {
      walkscore: search["walkscore"],
      description: search["description"],
      transit_score: search["transit"]["score"],
      bike_score: search["bike"]["score"]
    }
  end
end
