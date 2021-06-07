require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  test "Se puede borrar un usuario con una cuenta asociada" do
    email = users(:jesus).email
    user  = User.find_by(email: email)
    
    assert user.destroy
  end

end
