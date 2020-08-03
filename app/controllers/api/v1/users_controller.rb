class Api::V1::UsersController < ApplicationController

  def create
    json = JSON.parse(request.body.read, symbolize_names: true)
    binding.pry
  end
end
