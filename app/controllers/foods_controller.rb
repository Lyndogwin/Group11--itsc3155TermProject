class FoodsController < ApplicationController
    def index
        @foods = Food.all
        @foodClass = FoodClass.all
    end

      def new
        @foodClass = FoodClass.all
        @food = Food.new
    end
    def create 
        @food = Food.new(food_params)
        # ---byebug 
        if @food.save # will return false is save is called on an invalid food
            # ---byebug 
            redirect_to filtered_data_path 
        else
            render 'new'
        end
    end
    
    def show
        @foods = Food.all
        @foodClass = FoodClass.all
        @reviews = nil
        
        # check if the parameter passed is a FoodClass model
        if FoodClass.exists?(:name => params[:format])
            @specific_foods = Food.where(FoodClass_id: FoodClass.where(name: params[:format]))
        elsif contains_letter(params[:format])
            @specific_foods = Food.where(tod: params[:format])
        else
            @specific_foods = Food.where(id: params[:format])
        end
        @reviews = Review.where(food_id: @specific_foods.ids)
    end
    
    def edit
        @food = Food.where(id: params[:format])
    end
    
end
private
def food_params
   params.require(:food).permit(:name, :FoodClass_id, :tod) 
end
def contains_letter(str)
  str =~ /[a-z]/
end

