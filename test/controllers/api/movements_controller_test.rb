require "test_helper"

class MovementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user     = users(:jesus)
    @account  = accounts(:account_jesus)
  end

  test "Se crea un movimiento correctamente" do
    # Login
    endpoint = getApiRoute() + '/users'
    get endpoint, 
        params: { 
          email: @user.email, 
          password: @user.password 
        }, 
        as: :json

    token =  JSON.parse( @response.body )["token"]

    # Crear un movimiento
    endpoint = getApiRoute() + '/movements' 
    post endpoint, 
        headers: { 
          Authorization: 'Bearer ' + token 
        },
        params: { 
          balance: 15, 
          when: '2021-05-24',
          account_id: @account.id
        }, 
        as: :json

    assert_response :success
  end

end
