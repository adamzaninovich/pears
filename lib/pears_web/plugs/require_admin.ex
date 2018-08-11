defmodule PearsWeb.Plugs.RequireAdmin do
  import Plug.Conn
  import Phoenix.Controller

  alias PearsWeb.Router.Helpers

  def init(_init_params) do
  end

  def call(conn = %{assigns: %{user: user}}, _init_params) do
    case user.admin do
      true -> conn
      false -> 
        conn
        |> put_flash(:error, "Your account is pending activation.")
        |> redirect(to: Helpers.image_path(conn, :index))
        |> halt()
    end
  end
  def call(conn, _init_params), do: halt(conn)
end