defmodule BillCrudWeb.PageController do
  use BillCrudWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
