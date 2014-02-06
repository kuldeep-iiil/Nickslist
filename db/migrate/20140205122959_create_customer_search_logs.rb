class CreateCustomerSearchLogs < ActiveRecord::Migration
  def change
    create_table :customer_search_logs do |t|
      t.column :CustomerSearchID, :integer, :limit => 11, :null => false
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :SearchedDateTime, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE customer_search_logs
      ADD CONSTRAINT fk_customer_search_logs_CustSearchID
      FOREIGN KEY (CustomerSearchID)
      REFERENCES customer_searches(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE customer_search_logs
      ADD CONSTRAINT fk_customer_search_logs_UserID
      FOREIGN KEY (UserID)
      REFERENCES subscribed_users(id)
    SQL
  end
end