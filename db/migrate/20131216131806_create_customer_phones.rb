class CreateCustomerPhones < ActiveRecord::Migration
  def change
    create_table :customer_phones do |t|
      t.column :CustomerSearchID, :integer, :limit => 11, :null => false
      t.column :ContactNumber, :string, :limit => 20, :null => false
      t.column :DateCreated, :datetime, :null => false
    end
  end
end
