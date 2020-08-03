require 'rails_helper'

describe 'POST /api/v1/road_trip' do
  it 'Can create a road trip for an authenticated user' do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "origin" => "Denver,CO",
      "destination" => "Pueblo,CO",
      "api_key" => "jgn983hy48thw9begh98h4539h4"
    }
    post "/api/v1/road_trip", params: body.to_json, headers: headers

    expect(response).to be_successful

    road_trip = JSON.parse(response.body, symbolize_names: true)
    road_trip = road_trip[:data][:attributes]
    expect(road_trip[:origin]).to eq("Denver,CO")
    expect(road_trip[:destination]).to eq("Pueblo,CO")
    expect(road_trip[:travel_time].present?).to eq(true)
    expect(road_trip[:forecast].present?).to eq(true)
  end

  it 'Returns a 401 error if api key is missing' do
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "origin" => "Denver,CO",
      "destination" => "Pueblo,CO",
    }
    post "/api/v1/road_trip", params: body.to_json, headers: headers

    expect(response.status).to eq(401)
    expect(response.body).to eq("Missing API Key")
  end

  it 'Returns a 401 error if api key is incorrect' do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "123456789")
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "origin" => "Denver,CO",
      "destination" => "Pueblo,CO",
      "api_key" => "jgn983hy48thw9begh98h4539h4"
    }
    post "/api/v1/road_trip", params: body.to_json, headers: headers

    expect(response.status).to eq(401)
    expect(response.body).to eq("Invalid API Key")
  end

  it 'Returns a 400 error if origin is missing' do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "origin" => "",
      "destination" => "Pueblo,CO",
      "api_key" => "jgn983hy48thw9begh98h4539h4"
    }
    post "/api/v1/road_trip", params: body.to_json, headers: headers

    expect(response.status).to eq(400)
    expect(response.body).to eq("Missing origin location")
  end

  it 'Returns a 400 error if destination is missing' do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "origin" => "Denver,CO",
      "destination" => "",
      "api_key" => "jgn983hy48thw9begh98h4539h4"
    }
    post "/api/v1/road_trip", params: body.to_json, headers: headers

    expect(response.status).to eq(400)
    expect(response.body).to eq("Missing destination location")
  end
end
