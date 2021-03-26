defmodule Flightex.Flight.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys @keys

  defstruct @keys

  def build(data_completa, cidade_origem, cidade_destino, id_usuario) do
    data = convert_datetime(data_completa)
    handle_build(data, cidade_origem, cidade_destino, id_usuario)
  end

  defp handle_build({:ok, data_completa}, cidade_origem, cidade_destino, id_usuario)
       when cidade_origem != cidade_destino do
    uuid = UUID.uuid4()

    {:ok,
     %__MODULE__{
       id: uuid,
       data_completa: data_completa,
       cidade_origem: cidade_origem,
       cidade_destino: cidade_destino,
       id_usuario: id_usuario
     }}
  end

  defp handle_build({:ok, _data_completa}, _cidade_origem, _cidade_destino, _id_usuario),
    do: {:error, "Origin and Destination Cities are the same"}

  defp handle_build(
         {:error, _data_completa} = reason,
         _cidade_origem,
         _cidade_destino,
         _id_usuario
       ) do
    reason
  end

  defp convert_datetime({data, hora}) do
    with {:ok, data} <- Date.from_iso8601(data),
         {:ok, hora} <- Time.from_iso8601(hora) do
      NaiveDateTime.new(data, hora)
    end
  end
end
