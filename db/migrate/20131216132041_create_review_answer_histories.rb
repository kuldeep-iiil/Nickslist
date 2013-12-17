class CreateReviewAnswerHistories < ActiveRecord::Migration
  def change
    create_table :review_answer_histories do |t|
      t.column :ReviewID, :integer, :limit => 11, :null => false
      t.column :QuestionID, :integer, :limit => 11, :null => false
      t.column :Comments, :text
      t.column :IsYes, :string, :limit => 10
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
