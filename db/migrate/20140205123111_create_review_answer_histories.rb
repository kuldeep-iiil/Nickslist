class CreateReviewAnswerHistories < ActiveRecord::Migration
  def change
    create_table :review_answer_histories do |t|
      t.column :ReviewID, :integer, :limit => 11, :null => false
      t.column :QuestionID, :integer, :limit => 11, :null => false
      t.column :Comments, :text
      t.column :IsYes, :string, :limit => 50
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE review_answer_histories
      ADD CONSTRAINT fk_review_answer_histories_ReviewID
      FOREIGN KEY (ReviewID)
      REFERENCES reviews(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE review_answer_histories
      ADD CONSTRAINT fk_review_answer_histories_QuestionID
      FOREIGN KEY (QuestionID)
      REFERENCES review_questions(id)
    SQL
  end
end