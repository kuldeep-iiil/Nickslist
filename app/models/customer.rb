class Customer < ActiveRecord::Base
    self.table_name = 'Customers'
    self.primary_key = :ID

end
