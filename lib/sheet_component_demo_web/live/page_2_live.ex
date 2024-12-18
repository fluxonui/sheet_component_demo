defmodule SheetComponentDemoWeb.Page2Live do
  use SheetComponentDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-2xl font-bold">Hello from Page 2</h1>

      <div class="flex flex-col gap-4 mt-8">
        <p :for={i <- 1..100}>Content of page 2 to force scroll</p>
      </div>
    </div>
    """
  end
end
