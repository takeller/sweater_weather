class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params[:email])
    if user.nil?
      render json: "Could not find user with this email", status: 400
    elsif !user.authenticate(session_params[:password])
      render json: "Password is incorrect for this email", status: 400
    elsif user.authenticate(session_params[:password])
      render json: UserSerializer.new(user)
    end
  end

  private

  def session_params
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
