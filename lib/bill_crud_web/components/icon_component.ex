defmodule BillCrudWeb.Components.IconComponent do
  use Phoenix.Component

  def yellow(assigns) do
    ~H"""
    <div class="inline-block mr-2 ">
      <div class="flex items-center h-full pr-2">
        <svg
          class="w-6 h-6 mr-1 text-yellow-500"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          stroke-width="2"
          stroke="currentColor"
          fill="none"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path stroke="none" d="M0 0h24v24H0z" />
          <circle cx="12" cy="12" r="9" />
          <path d="M9 12l2 2l4 -4" />
        </svg>
        <p class="font-medium title-font"><%= @text %></p>
      </div>
    </div>
    """
  end

  def gray(assigns) do
    ~H"""
    <div class="inline-block mr-2 ">
      <div class="flex items-center h-full pr-2">
        <svg
          class="w-6 h-6 mr-1 text-gray-500"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <circle cx="12" cy="12" r="10" />
          <line x1="15" y1="9" x2="9" y2="15" />
          <line x1="9" y1="9" x2="15" y2="15" />
        </svg>
        <p class="font-medium title-font"><%= @text %></p>
      </div>
    </div>
    """
  end
end
