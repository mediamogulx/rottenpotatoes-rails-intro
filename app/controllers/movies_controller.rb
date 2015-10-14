class MoviesController < ApplicationController

  # See Section 4.5: Strong Parameters below for an explanation of this method:
  # http://guides.rubyonrails.org/action_controller_overview.html
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    @all_ratings = []
    @movies.each do |selectedMovie|
      if @all_ratings == []
        @all_ratings.push(selectedMovie.rating)
      else
        alreadyAdded = false
        @all_ratings.each do |selectedRating|
          if selectedRating == selectedMovie.rating 
            alreadyAdded = true
          end
        end
        if !alreadyAdded
          @all_ratings.push(selectedMovie.rating)
        end
      end
    end
    @all_ratings.sort!
    if params[:ratings] == nil
      params[:ratings] = session[:ratings]
    end
      @movies = @movies.filterByRating(params[:ratings])
    if params[:sort_by] == nil
      params[:sort_by] = session[:sort_by]
    end
    @movies = @movies.order(params[:sort_by])
    session[:ratings] = params[:ratings]
    session[:sort_by] = params[:sort_by]
    @selected_ratings = session[:ratings]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private :movie_params
  
end
