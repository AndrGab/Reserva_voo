defmodule Flightex.Flight.Report do
  alias Flightex.Flight.Booking
  alias Flightex.Flight.Agent, as: BookingAgent

  def create(data_inicial, data_final) do
    data_final = Date.from_iso8601(data_final)
    data_inicial = Date.from_iso8601(data_inicial)

    with {:ok, _msg} <- data_final,
         {:ok, _msg} <- data_inicial do
      booking_list = build_booking_list(data_inicial, data_final)
      File.write("report.csv", booking_list)
      {:ok, "Report generated successfully"}
    else
      error -> error
    end
  end

  defp build_booking_list({:ok, data_inicial}, {:ok, data_final}) do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.filter(fn booking ->
      inicial = Date.compare(booking.data_completa, data_inicial)
      final = Date.compare(booking.data_completa, data_final)
      (inicial == :eq or inicial == :gt) and (final == :eq or final == :lt)
    end)
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         id_usuario: id_usuario,
         cidade_origem: cidade_origem,
         cidade_destino: cidade_destino,
         data_completa: data_completa
       }) do
    data = NaiveDateTime.to_string(data_completa)
    "#{id_usuario},#{cidade_origem},#{cidade_destino},#{data}\n"
  end
end
