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

  it 'Can get the trail details for each trail' do
    get '/api/v1/trails?location=denver,co'

    expect(response).to be_successful

    trails = JSON.parse(response.body, symbolize_names: true)
    trails = trails[:data][:attributes][:trails]
    trails.each do |trail|
      expect(trail[:name].present?).to eq(true)
      expect(trail[:summary].present?).to eq(true)
      expect(trail[:difficulty].present?).to eq(true)
      expect(trail[:location].present?).to eq(true)
      expect(trail[:distance_to_trail].present?).to eq(true)
    end
  end

  it 'Can handle locations other than Denver' do
    get '/api/v1/trails?location=roanoke,va'

    expect(response).to be_successful

    trails = JSON.parse(response.body, symbolize_names: true)
    trails = trails[:data][:attributes][:trails]

    trails.each do |trail|
      expect(trail[:name].present?).to eq(true)
      expect(trail[:summary].present?).to eq(true)
      expect(trail[:difficulty].present?).to eq(true)
      expect(trail[:location].present?).to eq(true)
      expect(trail[:distance_to_trail].present?).to eq(true)
    end
  end
end
