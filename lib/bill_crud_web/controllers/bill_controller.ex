defmodule BillCrudWeb.BillController do
  use BillCrudWeb, :controller

  alias BillCrud.Pages
  alias BillCrud.Pages.Bill

  def index(conn, _params) do
    bills = Pages.list_bills()
    changeset = Pages.change_bill(%Bill{})
    total = Pages.total()

    render(conn, "index.html", bills: bills, changeset: changeset, total: total)
  end

  def new(conn, _params) do
    changeset = Pages.change_bill(%Bill{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bill" => bill_params}) do
    case Pages.create_bill(bill_params) do
      {:ok, bill} ->
        conn = conn
        |> put_flash(:info, "Bills created successfully.")

        if PhoenixTurbo.ControllerHelper.turbo_stream_request?(conn) do
          conn
          |> put_status(200)
          |> render(:form, conn: conn, changeset: Pages.change_bill(%Bill{}))
        else

          conn
          |> redirect(to: Routes.bill_path(conn, :index))
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bill = Pages.get_bill!(id)
    render(conn, "show.html", bill: bill)
  end

  def edit(conn, %{"id" => id}) do
    bill = Pages.get_bill!(id)
    changeset = Pages.change_bill(bill)
    render(conn, "edit.html", bill: bill, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bill" => bill_params}) do
    bill = Pages.get_bill!(id)

    case Pages.update_bill(bill, bill_params) do
      {:ok, bill} ->
        conn
        |> put_flash(:info, "Bills updated successfully.")
        |> redirect(to: Routes.bill_path(conn, :show, bill))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bill: bill, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bill = Pages.get_bill!(id)
    {:ok, _bill} = Pages.delete_bill(bill)

    conn
    |> put_flash(:info, "Bills deleted successfully.")
    |> redirect(to: Routes.bill_path(conn, :index))
  end
end
