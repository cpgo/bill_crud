defmodule BillCrud.PagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BillCrud.Pages` context.
  """

  @doc """
  Generate a bill.
  """
  def bill_fixture(attrs \\ %{}) do
    {:ok, bill} =
      attrs
      |> Enum.into(%{
        description: "some description",
        value: 42
      })
      |> BillCrud.Pages.create_bill()

    bill
  end
end
