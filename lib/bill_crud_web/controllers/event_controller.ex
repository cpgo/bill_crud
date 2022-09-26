defmodule BillCrudWeb.EventController do
  use BillCrudWeb, :controller

  alias BillCrud.Pages
  alias BillCrud.Pages.Events

  def index(conn, _params) do
    events = Pages.list_events()
    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
    changeset = Pages.change_events(%Events{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"events" => events_params}) do
    case Pages.create_event(events_params) do
      {:ok, events} ->
        conn
        |> put_flash(:info, "Events created successfully.")
        |> redirect(to: Routes.event_path(conn, :show, events))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    events = Pages.get_events!(id)
    # render(conn, "show.html", events: events)
    redirect(conn, to: Routes.event_bill_path(conn, :index, events))
  end

  def edit(conn, %{"id" => id}) do
    events = Pages.get_events!(id)
    changeset = Pages.change_events(events)
    render(conn, "edit.html", events: events, changeset: changeset)
  end

  def update(conn, %{"id" => id, "events" => events_params}) do
    events = Pages.get_events!(id)

    case Pages.update_events(events, events_params) do
      {:ok, events} ->
        conn
        |> put_flash(:info, "Events updated successfully.")
        |> redirect(to: Routes.event_path(conn, :show, events))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", events: events, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    events = Pages.get_events!(id)
    {:ok, _events} = Pages.delete_events(events)

    conn
    |> put_flash(:info, "Events deleted successfully.")
    |> redirect(to: Routes.event_path(conn, :index))
  end
end
