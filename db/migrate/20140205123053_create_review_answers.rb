class CreateReviewAnswers < ActiveRecord::Migration
  def change
    create_table :review_answers do |t|
      t.column :ReviewID, :integer, :limit => 11, :null => false
      t.column :QuestionID, :integer, :limit => 11, :null => false
      t.column :Comments, :text
      t.column :IsYes, :string, :limit => 50
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE review_answers
      ADD CONSTRAINT fk_review_answers_ReviewID
      FOREIGN KEY (ReviewID)
      REFERENCES reviews(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE review_answers
      ADD CONSTRAINT fk_review_answers_QuestionID
      FOREIGN KEY (QuestionID)
      REFERENCES review_questions(id)
    SQL
  end
end