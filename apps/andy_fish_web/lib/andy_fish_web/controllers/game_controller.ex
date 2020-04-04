defmodule AndyFishWeb.GameController do
  use AndyFishWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
