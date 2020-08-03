require 'rails_helper'

describe 'POST /api/v1/road_trip' do
  it 'Can create a road trip for an authenticated user' do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
    post "/api/v1/road_trip", params: body.to_json, headers: headers

    expect(response).to be_successful

    road_trip = JSON.parse(response.body, symbolize_names: true)
    road_trip = road_trip[:data][:attributes]

    expect(road_trip[:origin]).to eq("Denver, CO")
    expect(road_trip[:destination]).to eq("Pueblo, CO")
    expect(road_trip[:travel_time]).to eq("2 Hours")
    expect(road_trip[:arrival_forecast].present?).to eq(true)
  end
end
