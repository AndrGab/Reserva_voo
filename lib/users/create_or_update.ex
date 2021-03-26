defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def create_user(%{name: name, email: email, cpf: cpf}) do
    name
    |> User.build(email, cpf)
    |> save_user()
  end

  def update_user(%{name: name, email: email, cpf: cpf, id: id}) do
    %User{name: name, email: email, cpf: cpf, id: id}
    |> UserAgent.update()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)
  end

  defp save_user({:error, _reason} = error), do: error
end
