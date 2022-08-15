defmodule BillCrud.Pages do
  @moduledoc """
  The Pages context.
  """

  import Ecto.Query, warn: false
  alias BillCrud.Repo

  alias BillCrud.Pages.Bill

  @doc """
  Returns the list of bills.

  ## Examples

      iex> list_bills()
      [%Bill{}, ...]

  """
  def list_bills do
    Bill
    |> order_by(:inserted_at)
    |> Repo.all()
  end

  @doc """
  Gets a single bill.

  Raises `Ecto.NoResultsError` if the Bill does not exist.

  ## Examples

      iex> get_bill!(123)
      %Bill{}

      iex> get_bill!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bill!(id), do: Repo.get!(Bill, id)

  @doc """
  Creates a bill.

  ## Examples

      iex> create_bill(%{field: value})
      {:ok, %Bill{}}

      iex> create_bill(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bill(attrs \\ %{}) do
    %Bill{}
    |> Bill.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bill.

  ## Examples

      iex> update_bill(bill, %{field: new_value})
      {:ok, %Bill{}}

      iex> update_bill(bill, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bill(%Bill{} = bill, attrs) do
    bill
    |> Bill.changeset(attrs)
    |> Repo.update()
  end

  def update_bill(%Bill{} = bill, attrs, :stream) do
    case update_bill(bill, attrs) do
      {:ok, bill} ->
        BillCrudWeb.Endpoint.update_stream(
          "bills-index",
          BillCrudWeb.BillView,
          "index-row.turbo-html",
          bill: bill,
          stream_action: "replace",
          target: "bill-#{bill.id}-row"
        )
        {:ok, bill}
      {status, bill} ->
        {status, bill}
    end
  end

  @doc """
  Deletes a bill.

  ## Examples

      iex> delete_bill(bill)
      {:ok, %Bill{}}

      iex> delete_bill(bill)
      {:error, nil}

  """

  def delete_bill(%Bill{id: id}) do
    delete_bill(id)
  end

  def delete_bill(id) do
    case from(x in Bill, where: x.id == ^id) |> Repo.delete_all() do
      {1, nil} -> {:ok, id}
      _ -> {:error, nil}
    end
  end

  def delete_bill(id, :stream) do
    # TODO handle error
    BillCrudWeb.RenderHelper.broadcast_inline_stream("remove", "bill-#{id}-row", "bills-index")

    delete_bill(id)
  end

  @doc """
  Deletes all.

  ## Examples

      iex> delete_bill(bill)
      {:ok, %Bill{}}

      iex> delete_bill(bill)
      {:error, %Ecto.Changeset{}}

  """
  def delete_all_bills() do
    Repo.delete_all(Bill)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bill changes.

  ## Examples

      iex> change_bill(bill)
      %Ecto.Changeset{data: %Bill{}}

  """
  def change_bill(%Bill{} = bill, attrs \\ %{}) do
    Bill.changeset(bill, attrs)
  end
end
