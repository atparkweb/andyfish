defmodule AndyfishWeb.PageController do
  use AndyfishWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
