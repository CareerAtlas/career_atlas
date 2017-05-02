class Api::WalkscoresController < ApplicationController

  def index
    walk_score = WalkscoreApi.search_walkscore(params)
    render json: walk_score
  end

end
