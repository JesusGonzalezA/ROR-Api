require "application_system_test_case"

class MovimientosTest < ApplicationSystemTestCase
  setup do
    @movimiento = movimientos(:one)
  end

  test "visiting the index" do
    visit movimientos_url
    assert_selector "h1", text: "Movimientos"
  end

  test "creating a Movimiento" do
    visit movimientos_url
    click_on "New Movimiento"

    fill_in "Cuenta", with: @movimiento.cuenta_id
    fill_in "Fecha hora", with: @movimiento.fecha_hora
    fill_in "Importe", with: @movimiento.importe
    click_on "Create Movimiento"

    assert_text "Movimiento was successfully created"
    click_on "Back"
  end

  test "updating a Movimiento" do
    visit movimientos_url
    click_on "Edit", match: :first

    fill_in "Cuenta", with: @movimiento.cuenta_id
    fill_in "Fecha hora", with: @movimiento.fecha_hora
    fill_in "Importe", with: @movimiento.importe
    click_on "Update Movimiento"

    assert_text "Movimiento was successfully updated"
    click_on "Back"
  end

  test "destroying a Movimiento" do
    visit movimientos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Movimiento was successfully destroyed"
  end
end
