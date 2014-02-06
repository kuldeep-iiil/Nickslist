class CreateUserSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :user_subscription_plans do |t|
      t.column :PlanType, :string, :limit => 50, :null => false
      t.column :PlanDescription, :string, :limit => 200, :null => false
      t.column :price, :string, :limit => 10, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
