require 'rails_helper'

describe 'POST /api/v1/users' do
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

    expect(user[:type]).to eq('user')
    expect(user[:attributes][:email]).to eq(body["email"])
    expect(user[:attributes][:api_key].present?).to eq(true)
  end

  it 'Gets a 400 status code if password is missing' do
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "email" => "whatever@example.com",
      "password" => "",
      "password_confirmation" => "password"
    }
    post "/api/v1/users", params: body.to_json, headers: headers

    expect(response.status).to eq(400)
    expect(response.body).to eq("Password can't be blank")
  end

  it 'Gets a 400 status code if passwords dont match' do
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "email" => "whatever@example.com",
      "password" => "password",
      "password_confirmation" => "test"
    }
    post "/api/v1/users", params: body.to_json, headers: headers

    expect(response.status).to eq(400)
    expect(response.body).to eq("Password confirmation doesn't match Password")
  end

  it 'Gets a 400 status code if email is not unique' do
    User.create(email: "whatever@example.com", password: "test", password_confirmation: "test")
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "email" => "whatever@example.com",
      "password" => "password",
      "password_confirmation" => "password"
    }
    post "/api/v1/users", params: body.to_json, headers: headers

    expect(response.status).to eq(400)
    expect(response.body).to eq("Email has already been taken")
  end

  it 'Gets a 400 status code if email is empty' do
    headers = { "Content-Type" => "application/json", "Accept" => "application/json"}
    body = {
      "email" => "",
      "password" => "password",
      "password_confirmation" => "password"
    }
    post "/api/v1/users", params: body.to_json, headers: headers

    expect(response.status).to eq(400)
    expect(response.body).to eq("Email can't be blank")
  end
end
