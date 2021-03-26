defmodule Flightex.Flight.ReportTest do
  use ExUnit.Case
  import Flightex.Factory
  alias Flightex.Flight.CreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Flight.Report

  describe "create/1" do
    test "creates the report file" do
      Flightex.start_agents()

      user = build(:user)
      UserAgent.update(user)

      params1 = %{
        data_completa: {"2021-12-25", "20:00:00"},
        cidade_origem: "Londrina",
        cidade_destino: "São Paulo",
        id_usuario: "id"
      }

      CreateOrUpdate.create_booking(params1)

      expected_response = "id,Londrina,São Paulo,2021-12-25 20:00:00\n"

      Report.create("2021-01-01", "2021-12-31")

      response = File.read!("report.csv")

      assert response == expected_response
    end
  end
end
