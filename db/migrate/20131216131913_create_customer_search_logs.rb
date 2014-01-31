class CreateCustomerSearchLogs < ActiveRecord::Migration
  def change
    create_table :customer_search_logs do |t|
      t.column :CustomerSearchID, :integer, :limit => 11, :null => false
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :SearchedDateTime, :datetime, :null => false
    end
  end
end
