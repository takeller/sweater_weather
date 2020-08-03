require 'rails_helper'

describe 'GET /api/v1/backgrounds' do
  it 'Can get an image for a location' do
    get "/api/v1/backgrounds?location=denver,co"

    expect(response).to be_successful
    background_image = JSON.parse(response.body, symbolize_names: true)

    expect(background_image[:data][:attributes][:image_url].present?).to eq(true)
  end
end
