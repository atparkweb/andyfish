defmodule AndyFishWeb.SessionController do
  use AndyFishWeb, :controller
  
  alias AndyFish.Accounts
  alias AndyFishWeb.Auth
  
  def new(conn, _) do
    render(conn, "new.html")
  end
  
  def create(conn, %{"session" => %{"email" => email, "password" => password }}) do
    case Accounts.authenticate_by_email_password(email, password) do
      {:ok, user} ->
        conn
	|> Auth.login(user)
	|> put_flash(:info, "Welcome back!")
	|> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
	|> render("new.html")
    end
  end
  
  def delete(conn, _) do
    conn
    |> Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
