defmodule BillCrudWeb.PageControllerTest do
  use BillCrudWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "New Event"
  end
end
