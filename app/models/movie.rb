class Movie < ActiveRecord::Base
    def self.filterByRating(ratings)
        if ratings
            strRatings = []
            ratings.each_key do |selectedRating|
                strRatings.push(selectedRating.to_s)
            end
            Movie.where('rating IN (?)', strRatings)
        else
            all
        end
    end
end
