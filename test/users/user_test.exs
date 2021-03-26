defmodule Flightex.Users.UserTest do
  use ExUnit.Case
  alias Flightex.Users.User
  import Flightex.Factory

  describe "build/3" do
    test "when all params are valid, returns the user" do
      response =
        User.build(
          "Andre",
          "and@email.com",
          "1234567"
        )

      {:ok, %User{id: id}} = response
      expected_response = {:ok, build(:user, id: id)}

      assert response == expected_response
    end

    test "when CPF is invalid, returns error" do
      response =
        User.build(
          "Andre",
          "and@email.com",
          1_234_567
        )

      expected_response = {:error, "CPF is not a string"}

      assert response == expected_response
    end
  end
end
