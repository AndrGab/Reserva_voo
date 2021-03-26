defmodule Flightex do
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUser
  alias Flightex.Flight.CreateOrUpdate, as: CreateOrUpdateBook
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Flight.Agent, as: BookingAgent
  alias Flightex.Flight.Report

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_user(params), to: CreateOrUpdateUser, as: :create_user
  defdelegate get_user_by_id(params), to: UserAgent, as: :get_id
  defdelegate get_user_by_cpf(params), to: UserAgent, as: :get_cpf
  defdelegate list_all_users, to: UserAgent, as: :list_all
  defdelegate update_user(params), to: CreateOrUpdateUser, as: :update_user
  defdelegate create_booking(params), to: CreateOrUpdateBook, as: :create_booking
  defdelegate get_booking(params), to: BookingAgent, as: :get_id
  defdelegate list_all_bookings, to: BookingAgent, as: :list_all
  defdelegate generate_report(from_date, to_date), to: Report, as: :create
end
