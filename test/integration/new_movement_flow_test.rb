require "test_helper"

class NewMovementFlowTest < ActionDispatch::IntegrationTest
    setup do
        @user     = users(:jesus)
        @account  = accounts(:account_jesus)
    end

    test "El usuario crea un nuevo movimiento" do 
        # Login
        endpoint = getApiRoute() + '/users'
        get endpoint, 
            params: { 
                email: @user.email, 
                password: @user.password 
            }, 
            as: :json

        token =  JSON.parse( @response.body )["token"]
        assert_response :success, "Se hace el login correctamente"

        # Lista los movimientos
        endpoint = getApiRoute() + '/movements' 
        get endpoint, 
                headers: { 
                Authorization: 'Bearer ' + token 
            }
        num_movements =  JSON.parse(@response.body).length
        assert_response :success, "Lista los movimientos correctamente"

        # Creo un nuevo movimiento
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

        assert_response :success, "Se crea correctamente"

        # Vuelvo a listar los movimientos
        endpoint = getApiRoute() + '/movements' 
        get endpoint, 
                headers: { 
                Authorization: 'Bearer ' + token 
            }
        num_movements2 =  JSON.parse(@response.body).length
        assert_response :success, "Lista los movimientos correctamente"

        assert_equal(num_movements + 1, num_movements2, "Se incrementa la longitud del array de movimientos")
    end
end