class Key < ActiveRecord::Base
    self.table_name = 'Keys'
    self.primary_key = :ID
end
