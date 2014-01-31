class CreateFaqChanges < ActiveRecord::Migration
  def change
    change_table :faqs do |t|
      t.change :Question, :string, :limit => 200, :null => false
    end
  end
end
