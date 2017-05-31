class GlobalSetting < ApplicationRecord
  before_save :only_one_active

  private

    def only_one_active
      if self.active && !GlobalSetting.find_by(active: true).nil?
        old_active = GlobalSetting.find_by(active: true)
        old_active.active = false
        old_active.save
      end
    end

end
