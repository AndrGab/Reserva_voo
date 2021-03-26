defmodule Flightex.Users.Agent do
  alias Flightex.Users.User

  use Agent

  def start_link(_initial_start) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{cpf: cpf, id: id} = user) do
    already_exist = Enum.find_value(list_all(), fn user1 -> return_cpf(user1) == cpf end)

    case already_exist do
      nil ->
        Agent.update(__MODULE__, &update_state(&1, user))
        {:ok, id}

      _ ->
        {:error, "This CPF is already used"}
    end
  end

  def update(%User{} = user) do
    Agent.update(__MODULE__, &update_state(&1, user))
    {:ok, "User Updated"}
  end

  def get_id(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  def get_cpf(cpf) do
    user = Enum.find(list_all(), fn user -> return_cpf(user) == cpf end)

    case user do
      nil ->
        {:error, "User not found"}

      _ ->
        {_key, map} = user
        {:ok, map}
    end
  end

  def list_all, do: Agent.get(__MODULE__, & &1)

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{id: id} = user), do: Map.put(state, id, user)

  defp return_cpf({_key, map}) do
    Map.get(map, :cpf)
  end
end
