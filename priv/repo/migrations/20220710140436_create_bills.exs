defmodule BillCrud.Repo.Migrations.CreateBills do
  use Ecto.Migration

  def change do
    create table(:bills) do
      add :description, :string
      add :value, :integer

      timestamps()
    end
  end
end
