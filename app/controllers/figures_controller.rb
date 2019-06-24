class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

   post '/figures' do
    @figure = Figure.create(params[:figure])

     if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

     if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

     redirect "figures/#{@figure.id}"
  end

   get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

   get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

   get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

   patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    @figure.landmarks.clear
    @figure.titles.clear

     if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |landmark_id|
        landmark = Landmark.find(landmark_id)
        @figure.landmarks << landmark
      end
    end

     if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |title_id|
        title = Title.find(title_id)
        @figure.titles << title
      end
    end

     if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

     if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

     @figure.save

     redirect "figures/#{@figure.id}"
  end

end
