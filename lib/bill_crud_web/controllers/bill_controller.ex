defmodule BillCrudWeb.BillController do
  use BillCrudWeb, :controller

  alias BillCrud.Pages
  alias BillCrud.Pages.Bill

  def index(conn, _params) do
    bills = Pages.list_bills()
    changeset = Pages.change_bill(%Bill{})
    render(conn, "index.html", bills: bills, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Pages.change_bill(%Bill{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bill" => bill_params}) do
    case Pages.create_bill(bill_params) do
      {:ok, bill} ->
        if PhoenixTurbo.ControllerHelper.turbo_stream_request?(conn) do
          BillCrudWeb.Endpoint.update_stream(
            "bills-index",
            BillCrudWeb.BillView,
            "index-row.turbo-html",
            bill: bill,
            stream_action: "append",
            target: "bills-index"
          )

          conn
          |> put_status(200)
          |> render(:form, conn: conn, changeset: Pages.change_bill(%Bill{}))
        else
          conn
          |> put_flash(:info, "Bill created successfully.")
          |> redirect(to: Routes.bill_path(conn, :show, bill))
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(422)
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bill = Pages.get_bill!(id)
    render(conn, :show, bill: bill)
  end

  def edit(conn, %{"id" => id}) do
    bill = Pages.get_bill!(id)
    changeset = Pages.change_bill(bill)
    render(conn, :edit, bill: bill, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bill" => bill_params}) do
    bill = Pages.get_bill!(id)

    case Pages.update_bill(bill, bill_params, :stream) do
      {:ok, _bill} ->
        conn
        |> put_flash(:info, "Bill updated successfully.")
        |> redirect(to: Routes.bill_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(422)
        |> render("edit.html", bill: bill, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Pages.delete_bill(id, :stream) do
      {:ok, ^id} ->
        if PhoenixTurbo.ControllerHelper.turbo_stream_request?(conn) do
          conn
          |> put_status(200)
          |> render(:form, conn: conn, changeset: Pages.change_bill(%Bill{}))
        else
          conn
          |> put_flash(:info, "Bill deleted successfully.")
          |> redirect(to: Routes.bill_path(conn, :index))
        end
    end
  end
end
