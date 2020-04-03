defmodule AndyFishWeb.PageControllerTest do
  use AndyFishWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to AndyFish!"
  end
end
