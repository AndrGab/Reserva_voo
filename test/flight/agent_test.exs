defmodule Flightex.Flight.AgentTest do
  use ExUnit.Case
  alias Flightex.Flight.Booking
  alias Flightex.Flight.Agent, as: BookingAgent
  alias Flightex.Users.Agent, as: UserAgent
  import Flightex.Factory

  describe "save/1" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "when all params are valid, returns the user" do
      user = build(:user)
      UserAgent.update(user)
      booking = build(:booking)
      assert BookingAgent.save(booking) == {:ok, "id"}
    end
  end

  describe "get_id/1" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "when all params are valid, returns the user" do
      user = build(:user)
      UserAgent.update(user)
      booking = build(:booking)
      BookingAgent.save(booking)

      response = BookingAgent.get_id("id")

      expected_response =
        {:ok,
         %Flightex.Flight.Booking{
           cidade_destino: "São Paulo",
           cidade_origem: "Londrina",
           data_completa: ~N[2021-12-25 20:00:00],
           id: "id",
           id_usuario: "id"
         }}

      assert response == expected_response
    end
  end

  describe "list_all/0" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "list all bookings" do
      user = build(:user)
      UserAgent.update(user)
      booking = build(:booking)
      BookingAgent.save(booking)

      response = BookingAgent.list_all()

      expected_response = %{
        "id" => %Booking{
          cidade_destino: "São Paulo",
          cidade_origem: "Londrina",
          data_completa: ~N[2021-12-25 20:00:00],
          id: "id",
          id_usuario: "id"
        }
      }

      assert response == expected_response
    end
  end
end
