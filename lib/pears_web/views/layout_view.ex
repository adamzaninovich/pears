defmodule PearsWeb.LayoutView do
  use PearsWeb, :view

  def render_auth_link(conn = %{assigns: %{user: _user}}) do
    link "Sign Out", to: auth_path(conn, :signout)
  end

  def render_auth_link(conn) do
    link "Sign in with Github", to: auth_path(conn, :request, "github")
  end
end
