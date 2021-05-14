require "application_system_test_case"

class CuentaTest < ApplicationSystemTestCase
  setup do
    @cuentum = cuenta(:one)
  end

  test "visiting the index" do
    visit cuenta_url
    assert_selector "h1", text: "Cuenta"
  end

  test "creating a Cuentum" do
    visit cuenta_url
    click_on "New Cuentum"

    fill_in "Saldo", with: @cuentum.saldo
    fill_in "Usuario", with: @cuentum.usuario_id
    click_on "Create Cuentum"

    assert_text "Cuentum was successfully created"
    click_on "Back"
  end

  test "updating a Cuentum" do
    visit cuenta_url
    click_on "Edit", match: :first

    fill_in "Saldo", with: @cuentum.saldo
    fill_in "Usuario", with: @cuentum.usuario_id
    click_on "Update Cuentum"

    assert_text "Cuentum was successfully updated"
    click_on "Back"
  end

  test "destroying a Cuentum" do
    visit cuenta_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cuentum was successfully destroyed"
  end
end
