require "test_helper"

class AccountTest < ActiveSupport::TestCase
  
  test "Se puede borrar una cuenta con movimientos asociados a ella" do
    account = accounts(:account_jesus)
    
    assert account.destroy
  end

end
