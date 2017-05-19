class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, null: false, default: ""

      t.timestamps
    end
  end
end
