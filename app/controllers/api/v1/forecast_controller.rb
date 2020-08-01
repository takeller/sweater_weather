class Api::V1::ForecastController < ApplicationController

  def index
    forecast_results = ForecastResults.new
    forecast_results.forecast(params[:location])
  end
end
