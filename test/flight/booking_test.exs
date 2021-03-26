defmodule Flightex.Flight.BookingTest do
  use ExUnit.Case
  alias Flightex.Flight.Booking
  import Flightex.Factory

  describe "build/4" do
    test "when all params are valid, returns the user" do
      response = Booking.build({"2021-12-25", "20:00:00"}, "Londrina", "São Paulo", "id")
      {:ok, %Booking{id: id}} = response
      expected_response = {:ok, build(:booking, id: id)}

      assert response == expected_response
    end

    test "when origin/destination Cities are the same, returns error" do
      response = Booking.build({"2021-12-25", "20:00:00"}, "Londrina", "Londrina", "id")
      expected_response = {:error, "Origin and Destination Cities are the same"}

      assert response == expected_response
    end

    test "when date/time are invalid, returns error" do
      response = Booking.build({"2021-13-25", "20:00:00"}, "Londrina", "Londrina", "id")
      expected_response = {:error, :invalid_date}

      assert response == expected_response
    end
  end
end
