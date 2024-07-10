defmodule PrebWeb.PackageLive do
  use PrebWeb, :live_view

  def mount(_, _, socket) do
    socket = assign(socket, builds: [])

    if connected?(socket) do
      Phoenix.PubSub.subscribe(Preb.PubSub, "builds")
      {:ok, socket}
    else
      {:ok, socket}
    end
  end

  def handle_info({:build, build}, socket) do
    {:noreply, assign(socket, builds: [build | socket.assigns.builds])}
  end

  def render(assigns) do
    ~H"""
    <div :for={build <- @builds}>
      <%= build.package_name %> @ <%= build.package_version %>
    </div>
    """
  end
end
