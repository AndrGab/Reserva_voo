defmodule Flightex.Flight.Agent do
  alias Flightex.Flight.Booking
  alias Flightex.Users.Agent, as: UserAgent

  use Agent

  def start_link(_initial_start) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{id: id, id_usuario: id_usuario, data_completa: data_completa} = booking) do
    with {:ok, _msg} <- already_exist(id_usuario, data_completa),
         {:ok, _msg} <- UserAgent.get_id(id_usuario) do
      Agent.update(__MODULE__, &update_state(&1, booking))
      {:ok, id}
    else
      error -> error
    end
  end

  defp already_exist(id_usuario, data_completa) do
    result =
      Enum.find_value(list_all(), fn booking ->
        return_flight(booking) == [id_usuario, data_completa]
      end)

    case result do
      nil -> {:ok, "Valid"}
      _ -> {:error, "User already has a Flight Booking for this Date/Time"}
    end
  end

  defp return_flight({_key, map}) do
    [Map.get(map, :id_usuario), Map.get(map, :data_completa)]
  end

  def get_id(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Flight Booking not found"}
      booking -> {:ok, booking}
    end
  end

  def list_all, do: Agent.get(__MODULE__, & &1)

  defp update_state(state, %Booking{id: id} = booking), do: Map.put(state, id, booking)
end
