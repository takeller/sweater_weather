require 'rails_helper'

describe 'POST /api/v1/sessions' do
  it 'can create a session for a user' do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "123456789")
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "email" => "whatever@example.com",
      "password" => "password"
    }
    post "/api/v1/sessions", params: body.to_json, headers: headers

    expect(response).to be_successful

    user = JSON.parse(response.body, symbolize_names: true)
    user = user[:data]

    expect(user[:type]).to eq('user')
    expect(user[:attributes][:email]).to eq(body["email"])
    expect(user[:attributes][:api_key]).to eq("123456789")
  end

  it 'Gets a 400 status code if users doesnt exist' do
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "email" => "whatever@example.com",
      "password" => "password",
    }
    post "/api/v1/sessions", params: body.to_json, headers: headers

    expect(response.status).to eq(400)
    expect(response.body).to eq("Could not find user with this email")
  end

  it 'Gets a 400 status code if credentials are bad ' do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "123456789")
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "email" => "whatever@example.com",
      "password" => "test",
    }
    post "/api/v1/sessions", params: body.to_json, headers: headers

    expect(response.status).to eq(400)
    expect(response.body).to eq("Password is incorrect for this email")
  end
end
