require 'rails_helper'

describe 'Forecast API' do
  it 'Can retrieve weather for a city' do

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast[:data].keys).to match_array([:current_weather])
  end
end
