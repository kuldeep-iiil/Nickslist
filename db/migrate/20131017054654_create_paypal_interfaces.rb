class CreatePaypalInterfaces < ActiveRecord::Migration
  def change
    create_table :paypal_interfaces do |t|

      t.timestamps
    end
  end
end
