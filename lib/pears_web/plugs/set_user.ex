defmodule PearsWeb.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Pears.Users

  def init(_init_params) do
  end

  def call(conn, _init_params) do
    user_id = get_session(conn, :user_id)
    cond do
      user = user_id && Users.get_user(user_id) ->
        assign(conn, :user, user)
      true -> 
        conn
    end
  end
end