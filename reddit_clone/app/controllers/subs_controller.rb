class SubsController < ApplicationController
  
  before_action :moderator, only: [:edit, :update]
  

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @subs.errors.full_messages
      render :new
    end

  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  def update
    @sub = current_user.moderated_subs.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @subs.errors.full_messages
      render :edit
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def moderator
    return if current_user.id != params[:id]
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
