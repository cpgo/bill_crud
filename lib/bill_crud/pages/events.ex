defmodule BillCrud.Pages.Events do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(events, attrs) do
    events
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
