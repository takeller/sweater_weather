require 'rails_helper'

describe 'Background API' do
  it 'Can get an image for a location' do
    get "/api/v1/backgrounds?location=denver,co"

    expect(response).to be_successful
    binding.pry
    background_image = JSON.parse(response.body, symbolize_names: true)
  end
end
