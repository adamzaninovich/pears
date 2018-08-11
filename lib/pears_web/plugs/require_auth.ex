defmodule PearsWeb.Plugs.RequireAuth do
  use Plug.Builder

  plug PearsWeb.Plugs.RequireUser
  plug PearsWeb.Plugs.RequireAdmin
end