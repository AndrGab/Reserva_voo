defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Users.User
  alias Flightex.Flight.Booking

  def user_factory do
    %User{
      name: "Andre",
      email: "and@email.com",
      cpf: "1234567",
      id: "id"
    }
  end

  def booking_factory do
    %Booking{
      data_completa: ~N[2021-12-25 20:00:00],
      cidade_destino: "São Paulo",
      cidade_origem: "Londrina",
      id_usuario: "id",
      id: "id"
    }
  end
end
