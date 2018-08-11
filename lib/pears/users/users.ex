defmodule Pears.Users do
  import Ecto.Query, warn: false
  alias Pears.Repo
  alias Pears.Users.User

  def get_or_create_user(attrs) do
    case Repo.get_by(User, email: attrs.email) do
      nil ->
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()
      user ->
        {:ok, user}
    end
  end

  def get_user(user_id) do
    Repo.get(User, user_id)
  end

  def adminify_user_by_email(email) do
    Repo.get_by(User, email: email)
    |> User.changeset(%{admin: true})
    |> Repo.update()
  end
end