class CuisinesController < ApplicationController
  def show
    @cuisine = Cuisine.find(params[:id])
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    cuisine_params = params.require(:cuisine).permit(:name)

    @cuisine = Cuisine.new(cuisine_params)

    if @cuisine.save 
      flash[:success] = 'Cozinha cadastrada com sucesso'
      redirect_to @cuisine
    else
      render :new
    end
  end 

end
