defmodule PearsWeb.AuthController do
  use PearsWeb, :controller
  plug Ueberauth

  alias Pears.Users

  def callback(conn = %{assigns: %{ueberauth_auth: auth}}, %{"provider" => provider}) do
    user_params = %{
      token: auth.credentials.token, 
      email: auth.info.email,
      provider: provider
    }
    signin(conn, user_params)
  end

  def callback(conn = %{assigns: %{ueberauth_failure: _failure}}, _params) do
    conn
    |> put_flash(:error, "Ueberauth failure")
    |> redirect(to: image_path(conn, :index))
  end

  def signout(conn, _params) do
    conn 
    |> configure_session(drop: true)
    |> redirect(to: image_path(conn, :index))
  end

  defp signin(conn, user_params) do
    case Users.get_or_create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: image_path(conn, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, "Error signing in: #{reason}")
        |> redirect(to: image_path(conn, :index))
    end
  end
end