defmodule PearsWeb.Plugs.RequireUser do
  import Plug.Conn
  import Phoenix.Controller

  alias PearsWeb.Router.Helpers

  def init(_init_params) do
  end

  def call(conn = %{assigns: %{user: _user}}, _init_params), do: conn

  def call(conn, _init_params) do
    conn
    |> redirect(to: Helpers.auth_path(conn, :request, "github"))
    |> halt()
  end
end