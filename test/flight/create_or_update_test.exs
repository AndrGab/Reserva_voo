defmodule Flightex.Flight.CreateOrUpdateTest do
  use ExUnit.Case
  alias Flightex.Flight.CreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent
  import Flightex.Factory

  describe "create_booking/1" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "when all params are valid, returns the id" do
      user = build(:user)
      UserAgent.update(user)

      params = %{
        data_completa: {"2021-12-25", "20:00:00"},
        cidade_origem: "Londrina",
        cidade_destino: "São Paulo",
        id_usuario: "id"
      }

      response = CreateOrUpdate.create_booking(params)
      {:ok, id} = response
      expected_response = {:ok, id}

      assert response == expected_response
    end
  end
end
