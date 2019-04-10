class ReviewsController < ApplicationController
    def index
        @foods = Food.all
    end

    def new
        @review = Review.new
    end
    def create
        @review = Review.new(review_params)
        # find reviews submited today that match the email and food_id of the 
        # review being submited
        @check_r = Review.find_by(updated_at: Date.today.all_day, email: @review.email, food_id: @review.food_id)
        @food = Food.where(id: @review[:food_id])
        if @review[:like] == 1
            @review[:dislike] = 0
        else
            @review[:dislike] = 1
        end
        
        if !@check_r.nil?
            # render an alert instend of new
            render 'new'
        elsif @review.save 
            # ---byebug 
            redirect_to welcome_index_path
            tally(@food)
        else
            render 'new'
        end
        
    end
    
    def show
        @foods = Food.all
        @food = Food.find_by()
        #@likecount = tally(@food)
    end
end
private
def review_params
   params.require(:review).permit(:food_id, :email, :like) 
end
# tally reviews
def tally(food)
    l_count = 0
    d_count = 0
    Review.all.each do |r|
        if food == Food.where(id: r[:food_id])
            l_count += r.like
            d_count += r.dislike
        end 
    end
    food.update(likes: l_count, dislikes: d_count)
    hash = food.to_json # for tests
end