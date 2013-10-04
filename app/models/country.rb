class Country < ActiveRecord::Base
    self.table_name = 'Country'
    self.primary_key = :ID

end