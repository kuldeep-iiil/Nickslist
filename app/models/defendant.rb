class Defendant < ActiveRecord::Base
    self.table_name = 'Defendants'
    self.primary_key = :ID

end
