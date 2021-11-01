defmodule Todolist.Schemas.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todolist.Schemas.{User}

  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:user_id)
  end
end
