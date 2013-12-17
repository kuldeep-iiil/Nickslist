class CreateReviewQuestions < ActiveRecord::Migration
  def change
    create_table :review_questions do |t|
      t.column :ParentID, :integer, :limit => 11
      t.column :Description, :text, :null => false
      t.column :Type, :string, :limit => 45, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
