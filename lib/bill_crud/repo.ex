defmodule BillCrud.Repo do
  use Ecto.Repo,
    otp_app: :bill_crud,
    adapter: Ecto.Adapters.Postgres
end
