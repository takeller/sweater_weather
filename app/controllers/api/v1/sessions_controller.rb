class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email])
    if user.nil?
      render json: "Could not find user with this email", status: 400
    elsif !user.authenticate(params[:session][:password])
      render json: "Password is incorrect for this email", status: 400
    elsif user.authenticate(params[:session][:password])
      render json: UserSerializer.new(user)
    end
  end
end
