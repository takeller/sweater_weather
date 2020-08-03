require 'rails_helper'

describe 'Trails Endpoint' do
  it 'Can get the current forecast for the start location' do
    get '/api/v1/trails?location=denver,co'

    expect(response).to be_successful

    current_forecast = JSON.parse(response.body, symbolize_names: true)
    current_forecast = current_forecast[:data][:attributes]

    expect(current_forecast[:location].present?).to eq(true)
    expect(current_forecast[:forecast].present?).to eq(true)
    expect(current_forecast[:forecast][:summary].present?).to eq(true)
    expect(current_forecast[:forecast][:temperature].present?).to eq(true)
  end
end
