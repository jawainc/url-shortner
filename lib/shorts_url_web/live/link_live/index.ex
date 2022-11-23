defmodule ShortsUrlWeb.LinkLive.Index do
  use ShortsUrlWeb, :live_view

  alias ShortsUrl.Links

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :links, list_links())}
  end

  @impl true
  def handle_event("delete", %{"key" => key}, socket) do
    link = Links.get_link!(key)
    {:ok, _} = Links.delete_link(link)

    {:noreply, assign(socket, :links, list_links())}
  end

  defp list_links do
    Links.list_links()
  end
end
