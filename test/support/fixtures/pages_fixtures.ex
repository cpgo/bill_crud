defmodule BillCrud.PagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BillCrud.Pages` context.
  """

  @doc """
  Generate a bill.
  """
  def bill_fixture(attrs \\ %{}) do
    event = event_fixture()

    {:ok, bill} =
      attrs
      |> Enum.into(%{
        description: "some description",
        value: 42,
        event_id: event.id
      })
      |> BillCrud.Pages.create_bill()

    bill
  end

  @doc """
  Generate a bill.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> BillCrud.Pages.create_event()

    event
  end
end
