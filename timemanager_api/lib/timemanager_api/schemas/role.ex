defmodule Todolist.Schemas.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :label, :string
    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:label])
    |> validate_required([:label])
  end
end
