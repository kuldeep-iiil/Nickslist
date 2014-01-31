class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.column :Question, :string, :limit => 200, :null => false
      t.column :Answers, :text, :null =>false
      t.column :IsEnabled, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
