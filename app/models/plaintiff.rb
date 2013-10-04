class Plaintiff < ActiveRecord::Base
    self.table_name = 'Plaintiffs'
    self.primary_key = :ID

end
