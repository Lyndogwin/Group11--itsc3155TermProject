module FoodsHelper
    def tally(food)
        count = 0
        Review.all.each do |r|
            if food[:id] == r.food_id
                count += r.like
            end 
        end
        return count
    end
end
