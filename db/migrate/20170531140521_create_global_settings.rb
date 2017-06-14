class CreateGlobalSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :global_settings do |t|
      t.string :name
      t.string :url
      t.string :base64_key
      t.boolean :active, default: false

      t.timestamps
    end

    add_index :global_settings, :name, unique:true
  end
end
