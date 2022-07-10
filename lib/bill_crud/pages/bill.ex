defmodule BillCrud.Pages.Bill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bills" do
    field :description, :string
    field :value, :integer

    timestamps()
  end

  @doc false
  def changeset(bill, attrs) do
    bill
    |> cast(attrs, [:description, :value])
    |> validate_required([:description, :value])
  end
end
