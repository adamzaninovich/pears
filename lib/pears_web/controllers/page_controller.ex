defmodule PearsWeb.PageController do
  use PearsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
