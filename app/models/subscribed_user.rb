class SubscribedUser < ActiveRecord::Base
    self.table_name = 'SubscribedUsers'
    self.primary_key = :ID

end
