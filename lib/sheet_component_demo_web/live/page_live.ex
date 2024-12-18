defmodule SheetComponentDemoWeb.PageLive do
  use SheetComponentDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(query_string_sheet_open: false)}
  end

  def handle_params(%{"open_query_string_sheet" => "true"}, _url, socket) do
    {:noreply, socket |> assign(query_string_sheet_open: true)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket |> assign(query_string_sheet_open: false)}
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

      <.sheet id="query-string-sheet" open={@query_string_sheet_open} class="max-w-md w-full">
        <h2 class="text-lg font-bold">Sheet from same LiveView</h2>

        <div class="mt-6 flex flex-col items-start gap-4">
          <.link navigate={~p"/?open_query_string_sheet=false"}>
            Close sheet from query string
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
        <.button as="link" navigate={~p"/?open_query_string_sheet=true"}>
          Open sheet from the query string
        </.button>
        <.button phx-click={Fluxon.open_dialog("root-sheet")}>
          Open sheet from the root (outside LiveView)
        </.button>
      </div>

      <div class="flex flex-col gap-4 mt-8">
        <p :for={_i <- 1..100}>Content of page 1 to force scroll</p>
      </div>
    </div>
    """
  end

  def handle_event("push-to-page-2", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/page-2")}
  end
end
