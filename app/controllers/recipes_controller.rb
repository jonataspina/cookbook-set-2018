class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update featured]

  def index
    @recipes = Recipe.where(featured: false)
    @featured_recipes = Recipe.where(featured: true)
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash[:alert] = 'Você deve informar todos os dados da receita'
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render :new
    end
  end

  def edit
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash[:alert] = 'Você deve informar todos os dados da receita'
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render :edit
    end
  end

  def featured
    @recipe.update(featured: true)
    flash[:success] = 'Receita marcada como destaque com sucesso!'
    redirect_to @recipe
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :image)
  end
end
