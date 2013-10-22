class City < ActiveRecord::Base
    self.table_name = 'Cities'
    self.primary_key = :ID

end
