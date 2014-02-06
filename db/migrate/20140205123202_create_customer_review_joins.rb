class CreateCustomerReviewJoins < ActiveRecord::Migration
  def change
    create_table :customer_review_joins do |t|
      t.column :CustomerSearchID, :integer, :limit => 11, :null => false
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :IsReviewGiven, :boolean, :null => false
      t.column :IsRequestSent, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE customer_review_joins
      ADD CONSTRAINT fk_customer_review_joins_CustSearchID
      FOREIGN KEY (CustomerSearchID)
      REFERENCES customer_searches(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE customer_review_joins
      ADD CONSTRAINT fk_customer_review_joins_UserID
      FOREIGN KEY (UserID)
      REFERENCES subscribed_users(id)
    SQL
  end
end