defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case
  alias Flightex.Users.CreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent
  import Flightex.Factory

  describe "create_user/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, returns the id" do
      params = %{
        name: "Andre",
        email: "and@email.com",
        cpf: "1234567"
      }

      response = CreateOrUpdate.create_user(params)
      {:ok, id} = response
      expected_response = {:ok, id}

      assert response == expected_response
    end
  end

  describe "update_user/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, update the user and returns ok" do
      user = build(:user)
      UserAgent.update(user)

      response = CreateOrUpdate.update_user(user)

      expected_response = {:ok, "User Updated"}

      assert response == expected_response
    end
  end
end
