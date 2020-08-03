require 'rails_helper'

describe 'GET /api/v1/forecast' do
  it 'Can retrieve weather for a city' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast[:data][:attributes].keys).to match_array([:location, :current, :hourly, :daily])
  end

  it 'Can get the current weather' do
    expected = [:weather, :time, :temp, :sunrise, :sunset, :feels_like, :humidity, :visibility, :uvi, :icon]

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast[:data][:attributes][:current].keys).to match_array(expected)
  end

  it 'Can get the hourly weather' do
    expected = [:time, :temp, :weather, :icon]

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast[:data][:attributes][:hourly][0].keys).to match_array(expected)
  end

  it 'Can get the daily weather' do
    expected = [:day, :weather, :icon, :precipitation, :high, :low]

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast[:data][:attributes][:daily][0].keys).to match_array(expected)
  end
end
