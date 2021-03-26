defmodule Flightex.Users.AgentTest do
  use ExUnit.Case
  alias Flightex.Users.User
  alias Flightex.Users.Agent, as: UserAgent
  import Flightex.Factory

  describe "save/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, returns the user" do
      user = build(:user)
      assert UserAgent.save(user) == {:ok, "id"}
    end

    test "when CPF already exists, returns error" do
      user = build(:user)
      UserAgent.update(user)
      assert UserAgent.save(user) == {:error, "This CPF is already used"}
    end
  end

  describe "update/1" do
    test "when user is updated, returns ok" do
      user = build(:user)
      UserAgent.start_link(%{})
      UserAgent.update(user)
      assert UserAgent.update(user) == {:ok, "User Updated"}
    end
  end

  describe "get_id/1" do
    test "when ID is correct, returns user" do
      user = build(:user)
      UserAgent.start_link(%{})
      UserAgent.update(user)

      assert UserAgent.get_id("id") ==
               {:ok, %User{cpf: "1234567", email: "and@email.com", id: "id", name: "Andre"}}
    end

    test "when ID is not correct, returns error" do
      user = build(:user)
      UserAgent.start_link(%{})
      UserAgent.update(user)

      assert UserAgent.get_id("error") == {:error, "User not found"}
    end
  end

  describe "get_cpf/1" do
    test "when CPF is correct, returns user" do
      user = build(:user)
      UserAgent.start_link(%{})
      UserAgent.update(user)

      assert UserAgent.get_cpf("1234567") ==
               {:ok, %User{cpf: "1234567", email: "and@email.com", id: "id", name: "Andre"}}
    end

    test "when CPF is not correct, returns user" do
      user = build(:user)
      UserAgent.start_link(%{})
      UserAgent.update(user)

      assert UserAgent.get_cpf("error") == {:error, "User not found"}
    end
  end

  describe "list_all/0" do
    test "list all users" do
      user = build(:user)
      UserAgent.start_link(%{})
      UserAgent.update(user)

      assert UserAgent.list_all() == %{
               "id" => %User{cpf: "1234567", email: "and@email.com", id: "id", name: "Andre"}
             }
    end
  end
end
