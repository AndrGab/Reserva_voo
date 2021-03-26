defmodule Flightex.Flight.CreateOrUpdate do
  alias Flightex.Flight.Agent, as: BookingAgent
  alias Flightex.Flight.Booking

  def create_booking(%{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino,
        id_usuario: id_usuario
      }) do
    data_completa
    |> Booking.build(cidade_origem, cidade_destino, id_usuario)
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{} = booking}) do
    BookingAgent.save(booking)
  end

  defp save_booking({:error, _reason} = error), do: error
end
