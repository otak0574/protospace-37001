class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:new, :edit,:show, :destroy, :index]
  before_action :move_to_registration, except: [:index, :show]
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end 

  def create 
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    unless current_user.id == @prototype.user_id
      redirect_to root_path
    end 
  end

  def update
    if @prototype.update(prototype_params)
     redirect_to prototype_path
    else
      render :edit,status: :unprocessable_entity
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_registration
  unless user_signed_in?
    redirect_to new_user_registration_path
  end
end
end
