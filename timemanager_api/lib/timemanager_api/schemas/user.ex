defmodule Todolist.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todolist.Schemas.{Clock, Workingtime}
  import Bcrypt

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string

    has_one :role, Role
    has_one :clock, Clock
    has_many :workingtimes, Workingtime
    #has_one :role, Role

    #virtual_field
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/^\w{1,}@\w{1,}\.\w{1,}$/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes:
      %{password: password}} = changeset) do
    change(changeset, add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
