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
  end
end
