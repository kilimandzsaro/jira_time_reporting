require 'test_helper'

class ComponentTest < ActiveSupport::TestCase
  setup do
    @c1 = components(:one)
  end

  test 'valid uniqueness of name' do
    c2 = Component.new(name: @c1.name)
    assert !c2.valid?
  end
end
