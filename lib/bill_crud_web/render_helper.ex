defmodule BillCrudWeb.RenderHelper do
  import Plug.Conn
  import Phoenix.Controller

  @doc """
  Renders a turbo-stream tag with specified action and target.
  ## Examples
  BillCrudWeb.RenderHelper.render_inline_stream(conn, "remove", "bills-index")
    <turbo-stream action="remove" target="bills_index">
      <template>

      </template>
    </turbo-stream>

  # rendered_show = BillCrudWeb.BillView.render("_row.html", %{conn: BillCrudWeb.Endpoint, bill: %BillCrud.Pages.Bill{id: :rand.uniform(999), description: "shiet", value: 8888}})
  # BillCrudWeb.RenderHelper.render_inline_stream(conn, "append", "bills-index", rendered_show)
    <turbo-stream action="remove" target="bills_index">
      <template>
        <div>
          content from "_row.html" here
        </div>
      </template>
    </turbo-stream>

  """

  def render_inline_stream(conn, action, target, rendered_template \\ nil) do
    rendered =
      BillCrudWeb.Components.TurboStreamComponent.stream_tag(%{
        action: action,
        target: target,
        inner_block: %{inner_block: fn _, _ -> rendered_template end}
      })
      |> Phoenix.HTML.Safe.to_iodata()
      |> IO.iodata_to_binary()

    conn
    |> put_resp_content_type("text/vnd.turbo-stream.html")
    |> text(rendered)
  end
end
