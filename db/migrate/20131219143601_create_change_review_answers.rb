class CreateChangeReviewAnswers < ActiveRecord::Migration
  def change
    #remove_column :review_answers, :IsYes, :string, :limit => 10
    #add_column :review_answers, :IsYes, :string, :limit => 50
     change_table :review_answers do |t|
      t.change :IsYes, :string, :limit => 50
    end
    
    change_table :review_answer_histories do |t|
      t.change :IsYes, :string, :limit => 50
    end
  end
end
