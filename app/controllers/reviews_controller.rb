class ReviewsController < ApplicationController

  def index
    # this is our list page for our reviews
    @price = params[:price]
    @cuisine = params[:cuisine]
    @location = params[:location]

    #start with all reviews
    @reviews = Review.all

    # filtering by price
    if @price.present?
      @reviews = @reviews.where(price: @price)
    end

    #fliter by cuisine
    if @cuisine.present?
      @reviews = @reviews.where(cuisine: @cuisine)
    end

    # search near the location
    if @location.present?
      @reviews = @reviews.near(@location)
    end

  end

  def new
    # the form for adding a new review
    @review = Review.new
  end

  def create
    # take info from form and add it to the model
    @review = Review.new(form_params)

    # we want to check if the model can be saved
    # if it is were going to the home page again
    # if it isn't, show the new form
    if @review.save
      redirect_to root_path
    else
      # show the view for new.html.erb
      render "new"
    end
  end

  def show
    # individual review page
    @review = Review.find(params[:id])
  end

  def destroy
    # find the individual review and destroy it
    @review = Review.find(params[:id])
    @review.destroy
    # redirect to the home page
    redirect_to root_path
  end

  def edit
    # find individual review to edit
    @review = Review.find(params[:id])
  end

  def update
    # find the individual review
    @review = Review.find(params[:id])
    # update with new info from form
     if @review.update(form_params)
    # redirect somewhere
      redirect_to review_path(@review)
    else
      render "edit"
    end
  end

  def form_params
    params.require(:review).permit(:title, :restaurant, :body, :score,
      :ambiance, :address)
  end

end
