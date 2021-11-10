defmodule TodolistWeb.RoleController do
  use TodolistWeb, :controller

  alias Todolist.Schemas
  alias Todolist.Schemas.Role

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    roles = Schemas.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %Role{} = role} <- Schemas.create_role(role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Schemas.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Schemas.get_role!(id)

    with {:ok, %Role{} = role} <- Schemas.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Schemas.get_role!(id)

    with {:ok, %Role{}} <- Schemas.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
