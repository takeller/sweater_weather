class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email])
    if user.authenticate(params[:session][:password])
      render json: UserSerializer.new(user)
    else
      render json: user.errors.full_messages.to_sentence, status: 400
    end
  end
end
