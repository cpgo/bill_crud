defmodule BillCrudWeb.RenderHelper do
  def render_inline_stream(action, target, rendered_template \\ nil) do
    BillCrudWeb.Components.TurboStreamComponent.stream_tag(%{
      action: action,
      target: target,
      inner_block: %{inner_block: fn _,_ -> rendered_template end}
    })
    |> Phoenix.HTML.Safe.to_iodata()
    |> IO.iodata_to_binary()
  end
end
