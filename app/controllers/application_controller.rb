class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do 
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do 
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  post '/recipes' do
    new_recipe = Recipe.create(params)
    redirect "/recipes/#{new_recipe.id}"
  end 

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    name = params[:name]
    ingredients = params[:ingredients]
    time = params[:cook_time]
    recipe = Recipe.find(params[:id])
    recipe.update(name: name, ingredients: ingredients, cook_time: time)
    redirect "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.delete
    redirect "/recipes"
  end
end
