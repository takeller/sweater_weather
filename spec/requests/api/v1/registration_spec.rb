require 'rails_helper'

describe 'Registration endpoint' do
  it 'Can post a new user' do
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "email" => "whatever@example.com",
      "password" => "password",
      "password_confirmation" => "password"
    }
    post "/api/v1/users", params: body.to_json, headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(201)

    user = JSON.parse(response.body, symbolize_names: true)
    user = user[:data]

    expect(user[:type]).to eq('users')
    expect(user[:attributes][:email]).to eq(body["email"])
    expect(user[:attributes][:api_key].present?).to eq(true)
  end
end
