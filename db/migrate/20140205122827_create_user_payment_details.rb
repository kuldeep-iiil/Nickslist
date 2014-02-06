class CreateUserPaymentDetails < ActiveRecord::Migration
  def change
    create_table :user_payment_details do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :TransactionAmount, :string, :limit => 10, :null => false
      t.column :BLTransactionID, :string, :limit => 50
      t.column :PayTransactionID, :string, :limit => 50, :null => false
      t.column :PaymentStatus, :boolean
      t.column :ResponseDateTime, :datetime
      t.column :ResponseString, :text, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE user_payment_details
      ADD CONSTRAINT fk_user_payment_details_UserID
      FOREIGN KEY (UserID)
      REFERENCES subscribed_users(id)
    SQL
  end
end