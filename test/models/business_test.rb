require 'test_helper'

class BusinessTest < ActiveSupport::TestCase

  setup do
    @b1 = businesses(:one)
  end

  test 'valid uniqueness of name' do
    b2 = Business.new(name: @b1.name)
    assert !b2.valid?
  end

  test 'valid uniqueness of jira_name' do
    b2 = Business.new(jira_name: :Free)
    assert !b2.valid?
  end
end
