require 'securerandom'

class Api::V1::UsersController < ApplicationController

  def create
    json = JSON.parse(request.body.read, symbolize_names: true)
    api_key = SecureRandom.uuid
    user = User.new(json)
    user.api_key = api_key
    if user.save
      render json: UserSerializer.new(user), status: 201
    elsif !user.save
      render json: user.errors.full_messages.to_sentence, status: 400
    end
  end
end
