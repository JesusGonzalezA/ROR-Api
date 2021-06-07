require "test_helper"
require 'json'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account  = accounts(:account_jesus)
    @account2 = accounts(:account_alejandro)
    @user     = users(:jesus)
    @user2    = users(:alejandro)
  end

  test "Un usuario no puede borrar las cuentas de otro" do
    # Login
    endpoint = getApiRoute() + '/users'
    get endpoint, 
        params: { 
          email: @user.email, 
          password: @user.password 
        }, 
        as: :json

    token =  JSON.parse( @response.body )["token"]

    # Delete account
    endpoint = getApiRoute() + '/accounts/' + @account2.id.to_s
    delete endpoint, 
        headers: { 
          Authorization: 'Bearer ' + token 
        }

    assert_response 422
  end

  test "Un usuario puede borrar su cuenta" do
    # Login
    endpoint = getApiRoute() + '/users'
    get endpoint, 
        params: { 
          email: @user.email, 
          password: @user.password 
        }, 
        as: :json

    token =  JSON.parse( @response.body )["token"]

    # Delete account
    endpoint = getApiRoute() + '/accounts/' + @account.id.to_s
    delete endpoint, 
        headers: { 
          Authorization: 'Bearer ' + token 
        }

    assert_response :success
  end

end
