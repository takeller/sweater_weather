class Api::V1::ForecastController < ApplicationController

  def index
    forecast_results = ForecastResults.new
    forecast = forecast_results.forecast(params[:location])
    binding.pry
    render json: ForecastSerializer.new(forecast)
  end
end
