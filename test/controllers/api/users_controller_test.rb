require "test_helper"
require 'json'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user  = users(:alejandro)
    @user2 = users(:jesus) 
  end

  test "Si la contraseña es correcta, hacer login" do
    endpoint = getApiRoute() + '/users'
    get endpoint, 
        params: { email: @user.email, password: @user.password }, 
        as: :json
    assert_response :success
  end

  test "Si la contraseña es incorrecta, no debería de dejarme hacer login" do
    endpoint = getApiRoute() + '/users'
    get endpoint, 
        params: { 
          email: @user.email, 
          password: @user.password + "INCORRECTA" 
        }, 
        as: :json

    assert_response :not_found
  end

  test "Si se actualiza el email a uno existente, debería de devolver un error" do
    # Login
    endpoint = getApiRoute() + '/users'
    get endpoint, 
        params: { 
          email: @user.email, 
          password: @user.password 
        }, 
        as: :json

    token =  JSON.parse( @response.body )["token"]

    # Update email
    put endpoint, 
        headers: { 
          Authorization: 'Bearer ' + token 
        }, 
        params: { 
          email: @user2.email 
        }, 
        as: :json

    assert_response 422
  end

end
