class AddRegionToGlobalSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :global_settings, :region, :string, default: :ee
  end
end
