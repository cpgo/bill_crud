defmodule BillCrudWeb.Components.EventSummary do
  use Phoenix.Component
  use Phoenix.HTML
  def text(assigns) do
    ~H"""
    <div class="w-1/2">
    <h2 class="text-gray-500"><%= @description %></h2>
    <p ><%= @value %></p>
    </div>
    """
  end

  def link_arrow(assigns) do
    ~H"""
        <%= link  to: BillCrudWeb.Router.Helpers.event_path(@conn, :show, @event), class: "inline-flex items-center mt-3 text-indigo-500" do %>
        Show
        <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="w-4 h-4 ml-2" viewBox="0 0 24 24">
          <path d="M5 12h14M12 5l7 7-7 7"></path>
        </svg>
        <% end %>
    """
  end
end
