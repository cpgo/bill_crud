defmodule BillCrudWeb.BillControllerTest do
  use BillCrudWeb.ConnCase

  import BillCrud.PagesFixtures

  @create_attrs %{description: "some description", value: 42}
  @update_attrs %{description: "some updated description", value: 43}
  @invalid_attrs %{description: nil, value: nil}

  describe "index" do
    test "lists all bills", %{conn: conn} do
      # test will fail when bill is properly scoped to event
      conn = get(conn, Routes.event_bill_path(conn, :index, 1))
      assert html_response(conn, 200) =~ "Total:"
    end
  end

  describe "new bill" do
    test "renders form", %{conn: conn} do
      # test will fail when bill is properly scoped to event
      conn = get(conn, Routes.event_bill_path(conn, :new, 1))
      assert html_response(conn, 200) =~ "Description"
    end
  end

  describe "create bill" do
    setup [:create_event]
    test "redirects to show when data is valid", %{conn: conn, event: event} do
      conn = post(conn, Routes.event_bill_path(conn, :create, event.id), bill: @create_attrs)

      assert redirected_to(conn) == Routes.event_bill_path(conn, :index, event.id)

      conn = get(conn, Routes.event_bill_path(conn, :index, event.id))
      assert html_response(conn, 200) =~ "Total: "
    end

    test "renders errors when data is invalid", %{conn: conn, event: event} do
      conn = post(conn, Routes.event_bill_path(conn, :create, event.id), bill: @invalid_attrs)
      assert html_response(conn, 422) =~ "can&#39;t be blank"
    end
  end

  describe "edit bill" do
    setup [:create_bill]

    test "renders form for editing chosen bill", %{conn: conn, bill: bill} do
      conn = get(conn, Routes.event_bill_path(conn, :edit, bill.event_id, bill))
      assert html_response(conn, 200) =~ "Edit Bill"
    end
  end

  describe "update bill" do
    setup [:create_bill]

    test "redirects when data is valid", %{conn: conn, bill: bill} do
      conn = put(conn, Routes.event_bill_path(conn, :update, bill.event_id, bill ), bill: @update_attrs, event_id: bill.event_id)
      assert redirected_to(conn) == Routes.event_bill_path(conn, :show, bill.event_id, bill)

      conn = get(conn, Routes.event_bill_path(conn, :show, bill.event_id, bill))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, bill: bill} do
      conn = put(conn, Routes.event_bill_path(conn, :update, bill.event_id, bill), bill: @invalid_attrs)
      assert html_response(conn, 422) =~ "Edit Bill"
    end
  end

  describe "delete bill" do
    setup [:create_bill]

    test "deletes chosen bill", %{conn: conn, bill: bill} do
      conn = delete(conn, Routes.event_bill_path(conn, :delete, bill.event_id, bill))
      assert redirected_to(conn) == Routes.event_bill_path(conn, :index, bill.event_id)

      assert_error_sent 404, fn ->
        get(conn, Routes.event_bill_path(conn, :show, bill.event_id, bill))
      end
    end
  end

  defp create_bill(_) do
    bill = bill_fixture()
    %{bill: bill}
  end

  defp create_event(_) do
    event = event_fixture()
    %{event: event}
  end
end
