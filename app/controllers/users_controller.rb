class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @name = @user.prototypes.name
    @prototype = @user.prototypes
  end
end
