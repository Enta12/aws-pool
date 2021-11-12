defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller

  alias Todolist.Schemas
  alias Todolist.Schemas.User

  action_fallback TodolistWeb.FallbackController

  def index(conn, %{"email" => email, "username" => username}) do
    users = Schemas.list_users!(email, username)
    render(conn, "index.json", users: users)
  end

  def index(conn, _params) do
    users = Schemas.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Schemas.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Schemas.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Schemas.get_user!(id)

    with {:ok, %User{} = user} <- Schemas.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Schemas.get_user!(id)

    with {:ok, %User{}} <- Schemas.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def signIn(conn, %{"email" => email, "password" => password}) do
    case Schemas.signIn(email, password) do
    {:ok, token, claims} ->
      conn
      |> put_resp_cookie("session_jwt", token)
      |> render("jwt.json", claims: claims)
      _ ->
      {:error, :unauthorized}
    end
  end

  #fonction logout pour suprimer les cookies
end
