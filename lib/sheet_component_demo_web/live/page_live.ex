defmodule SheetComponentDemoWeb.PageLive do
  use SheetComponentDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-2xl font-bold">Hello from Page 1</h1>

      <.sheet id="same-lv-sheet" class="max-w-md w-full">
        <h2 class="text-lg font-bold">Sheet from same LiveView</h2>

        <div class="mt-6 flex flex-col items-start gap-4">
          <.link navigate={~p"/page-2"}>
            Navigate to another LiveView
          </.link>
          <.link phx-click="push-to-page-2">
            Navigate via push_navigate
          </.link>
          <.link navigate={~p"/"}>
            Navigate to same LiveView
          </.link>
        </div>
      </.sheet>

      <div class="mt-6 flex flex-col items-start gap-4">
        <.button phx-click={Fluxon.open_dialog("same-lv-sheet")}>
          Open sheet from same LiveView
        </.button>
        <.button phx-click={Fluxon.open_dialog("template-sheet")}>
          Open sheet from the template
        </.button>
        <.button phx-click={Fluxon.open_dialog("root-sheet")}>
          Open sheet from the root (outside LiveView)
        </.button>
      </div>

      <div class="flex flex-col gap-4 mt-8">
        <p :for={i <- 1..100}>Content of page 1 to force scroll</p>
      </div>
    </div>
    """
  end

  def handle_event("push-to-page-2", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/page-2")}
  end
end
