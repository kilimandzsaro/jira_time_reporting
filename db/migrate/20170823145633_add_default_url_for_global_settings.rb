class AddDefaultUrlForGlobalSettings < ActiveRecord::Migration[5.0]
  def change
    GlobalSetting.create :name => "default", :url => "http://localhost", :active => true, :region => "ee"
  end
end
