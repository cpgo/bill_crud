defmodule BillCrud.Repo.Migrations.AddEventFkToBill do
  use Ecto.Migration

  def change do
    alter table("bills") do
      add :event_id, references(:events)
    end
  end
end
