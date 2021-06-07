require "test_helper"

class MovementTest < ActiveSupport::TestCase
 
  test "Se puede añadir un movimiento con balance negativo" do
    balance = -10
    when_at = '2021-05-24'
    id      = accounts(:account_alejandro).id

    movimiento = Movement.new(balance: balance, when: when_at, account_id: id)

    assert movimiento.save
  end

  test "No se puede añadir un movimiento a una cuenta inexistente" do
    balance = -10
    when_at = '2021-05-24'
    id      = -1

    movimiento = Movement.new(balance: balance, when: when_at, account_id: id)

    assert_not movimiento.save
  end

end
