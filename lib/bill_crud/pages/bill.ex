defmodule BillCrud.Pages.Bill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bills" do
    field :description, :string
    field :value, :integer
    belongs_to :event, BillCrud.Pages.Events
    timestamps()
  end

  @doc false
  def changeset(bill, attrs) do
    bill
    |> cast(attrs, [:description, :value, :event_id])
    |> validate_required([:description, :event_id])
  end
end
