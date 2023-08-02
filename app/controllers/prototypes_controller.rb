class PrototypesController < ApplicationController


  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params.require(:id))
    @comment = Comment.new
  end

  def edit
    @prototype = Prototype.find(params.require(:id))
    unless @prototype.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params.require(:id))
    if @prototype.update(prototype_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    prototype = Prototype.find(params.require(:id))
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
