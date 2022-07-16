defmodule BillCrudWeb.Components.TurboStreamComponent do
  use Phoenix.Component

  def stream_tag(assigns) do
    ~H"""
    <turbo-stream action={@action} target={@target}>
      <template>
        <%= render_slot(@inner_block) %>
      </template>
    </turbo-stream>
    """
  end
end
