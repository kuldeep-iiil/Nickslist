class CreateAuthorizeNets < ActiveRecord::Migration
  def change
    create_table :authorize_nets do |t|

      t.timestamps
    end
  end
end
