class ReviewHistory < ActiveRecord::Base
    self.table_name = 'ReviewsHistory'
    self.primary_key = :ID

end
