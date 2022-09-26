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
    changeset = Bill.changeset(%Bill{}, attrs)
    with {:ok, bill} <- Repo.insert(changeset) do
      broadcast_total()
      broadcast_row(bill)
      {:ok, bill}
    else
      {:error, changeset} ->
        {:error, changeset}
    end
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
    result = bill
    |> Bill.changeset(attrs)
    |> Repo.update()

    broadcast_total()
    result
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
        broadcast_total()
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

    deleted_bill = delete_bill(id)
    broadcast_total()
    deleted_bill
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

  def total() do
    Repo.one(from b in Bill, select: sum(b.value))
  end

  def broadcast_total() do
    rendered_total = BillCrudWeb.BillView.render("summary.html", %{total: total()})
    BillCrudWeb.RenderHelper.broadcast_inline_stream("replace", "summary", "bills-index", rendered_total)
  end

  def broadcast_row({:error, changeset}) do
    changeset
  end

  def broadcast_row(bill) do
    BillCrudWeb.Endpoint.update_stream(
      "bills-index",
      BillCrudWeb.BillView,
      "index-row.turbo-html",
      bill: bill,
      stream_action: "append",
      target: "bills-index"
    )
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

  alias BillCrud.Pages.Events

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Events{}, ...]

  """
  def list_events do
    Repo.all(Events)
  end

  @doc """
  Gets a single events.

  Raises `Ecto.NoResultsError` if the Events does not exist.

  ## Examples

      iex> get_events!(123)
      %Events{}

      iex> get_events!(456)
      ** (Ecto.NoResultsError)

  """
  def get_events!(id), do: Repo.get!(Events, id)

  @doc """
  Creates a events.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Events{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Events{}
    |> Events.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a events.

  ## Examples

      iex> update_events(events, %{field: new_value})
      {:ok, %Events{}}

      iex> update_events(events, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events(%Events{} = events, attrs) do
    events
    |> Events.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a events.

  ## Examples

      iex> delete_events(events)
      {:ok, %Events{}}

      iex> delete_events(events)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events(%Events{} = events) do
    Repo.delete(events)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events changes.

  ## Examples

      iex> change_events(events)
      %Ecto.Changeset{data: %Events{}}

  """
  def change_events(%Events{} = events, attrs \\ %{}) do
    Events.changeset(events, attrs)
  end
end
