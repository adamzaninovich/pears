defmodule PearsWeb.LayoutView do
  use PearsWeb, :view

  def render_auth_link(conn), do: render_auth_link(conn, [])

  def render_auth_link(%{assigns: %{user: _user}} = conn, attrs) do
    link("Sign Out", [to: auth_path(conn, :signout)] ++ attrs)
  end

  def render_auth_link(conn, attrs) do
    link("Sign in with Github", [to: auth_path(conn, :request, "github")] ++ attrs)
  end
end
