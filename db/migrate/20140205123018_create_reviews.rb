class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :CustomerSearchID, :integer, :limit => 11, :null => false
      t.column :IsPublished, :boolean, :null => false
      t.column :IsApproved, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE reviews
      ADD CONSTRAINT fk_reviews_CustSearchID
      FOREIGN KEY (CustomerSearchID)
      REFERENCES customer_searches(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE reviews
      ADD CONSTRAINT fk_reviews_UserID
      FOREIGN KEY (UserID)
      REFERENCES subscribed_users(id)
    SQL
  end
end