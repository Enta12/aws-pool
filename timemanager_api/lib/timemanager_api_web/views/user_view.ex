defmodule TodolistWeb.UserView do
  use TodolistWeb, :view
  alias TodolistWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("jwt.json", %{claims: claims}) do
    %{user_id: claims["user_id"], role_id: claims["role_id"], xrsf_token: claims["xsrf_token"]}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email
    }
  end
end
