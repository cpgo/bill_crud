defmodule BillCrudWeb.BillController do
  use BillCrudWeb, :controller

  alias BillCrud.Pages
  alias BillCrud.Pages.Bill

  def index(conn, %{"event_id" => event_id}) do
    bills = Pages.list_bills(event_id)
    changeset = Pages.change_bill(%Bill{}, %{event_id: event_id})
    total = Pages.total()
    render(conn, "index.html",
      bills: bills,
      changeset: changeset,
      total: total,
      event_id: event_id
    )
  end

  def new(conn, %{"event_id" => event_id}) do
    changeset = Pages.change_bill(%Bill{}, %{event_id: event_id})
    render(conn, "new.html", changeset: changeset, event_id: event_id)
  end

  def create(conn, %{"bill" => bill_params, "event_id" => event_id} = _params) do
    case Pages.create_bill(Map.put(bill_params, "event_id", event_id)) do
      {:ok, bill} ->
        conn =
          conn
          |> put_flash(:info, "Bills created successfully.")

        if PhoenixTurbo.ControllerHelper.turbo_stream_request?(conn) do
          conn
          |> put_status(200)
          |> render(:form, conn: conn, changeset: Pages.change_bill(%Bill{}, %{event_id: event_id}))
        else
          conn
          |> put_flash(:info, "Bills created successfully.")
          |> redirect(to: Routes.event_bill_path(conn, :index, bill.event_id))
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(422)
        |> render("new.html", changeset: changeset, event_id: event_id)
    end
  end

  def show(conn, %{"id" => id, "event_id" => event_id}) do
    bill = Pages.get_bill!(id)
    render(conn, "show.html", bill: bill, event_id: event_id)
  end

  def edit(conn, %{"id" => id}) do
    bill = Pages.get_bill!(id)
    changeset = Pages.change_bill(bill)
    render(conn, "edit.html", bill: bill, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bill" => bill_params}) do
    bill = Pages.get_bill!(id)

    case Pages.update_bill(bill, bill_params, :stream) do
      {:ok, bill} ->
        conn
        |> put_flash(:info, "Bills updated successfully.")
        |> redirect(to: Routes.event_bill_path(conn, :show, bill.event_id, bill))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(422)
        |> render("edit.html", bill: bill, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "event_id" => event_id}) do
    {:ok, _bill} = Pages.delete_bill(id, :stream)

    conn
    |> put_flash(:info, "Bills deleted successfully.")
    |> redirect(to: Routes.event_bill_path(conn, :index, event_id))
  end
end
