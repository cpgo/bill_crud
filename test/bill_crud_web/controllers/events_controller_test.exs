defmodule BillCrudWeb.EventsControllerTest do
  use BillCrudWeb.ConnCase

  import BillCrud.PagesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all events", %{conn: conn} do
      conn = get(conn, Routes.event_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Events"
    end
  end

  describe "new events" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.event_path(conn, :new))
      assert html_response(conn, 200) =~ "New Events"
    end
  end

  describe "create events" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.event_path(conn, :create), events: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.event_path(conn, :show, id)

      conn = get(conn, Routes.event_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Events"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.event_path(conn, :create), events: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Events"
    end
  end

  describe "edit events" do
    setup [:create_event]

    test "renders form for editing chosen events", %{conn: conn, event: event} do
      conn = get(conn, Routes.event_path(conn, :edit, event))
      assert html_response(conn, 200) =~ "Edit Events"
    end
  end

  describe "update events" do
    setup [:create_event]

    test "redirects when data is valid", %{conn: conn, event: event} do
      conn = put(conn, Routes.event_path(conn, :update, event), events: @update_attrs)
      assert redirected_to(conn) == Routes.event_bill_path(conn, :index, event.id)

      conn = get(conn, Routes.event_path(conn, :show, event))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, event: event} do
      conn = put(conn, Routes.event_path(conn, :update, event), events: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Events"
    end
  end

  describe "delete events" do
    setup [:create_event]

    test "deletes chosen events", %{conn: conn, event: event} do
      conn = delete(conn, Routes.event_path(conn, :delete, event))
      assert redirected_to(conn) == Routes.event_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.event_path(conn, :show, event))
      end
    end
  end

  defp create_event(_) do
    event = event_fixture()
    %{event: event}
  end
end
