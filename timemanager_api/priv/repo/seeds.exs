# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Todolist.Repo.insert!(%Todolist.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Todolist.Schemas

roles = [
  %{name: "manager"},
  %{name: "user"}
]

users = [
  %{username: "manager", email: "manager@epitech.eu", motdepasse: "motdepasse"},
  %{username: "Bernard", email: "Bernard@epitech.eu", motdepasse: "motdepasse"},
  %{username: "Sauterelle", email: "sauterelle@epitech.eu", motdepasse: "motdepasse"},
  %{username: "Flemkiche", email: "flemkiche@epitech.eu", motdepasse: "motdepasse"},
  %{username: "superbossdu91", email: "superbossdu91@epitech.eu", motdepasse: "motdepasse"},
]

Enum.each(roles, fn role -> Schemas.create_role(role) end)
Enum.each(users, fn user -> Schemas.create_user(user) end)
