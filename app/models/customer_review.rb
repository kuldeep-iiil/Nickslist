class CustomerReview < ActiveRecord::Base
    self.table_name = 'CustomerReviews'
    self.primary_key = :ID

end