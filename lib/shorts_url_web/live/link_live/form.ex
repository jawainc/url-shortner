
defmodule ShortsUrlWeb.LinkLive.Form do
  use ShortsUrlWeb, :live_view

  alias ShortsUrl.Links
  alias ShortsUrl.Links.Link

  @impl true
  def render(assigns) do
    ~H"""
    <%= if !@show_result do %>
      <.simple_form
        :let={f}
        for={@changeset}
        id="shortener-form"
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :url}} type="text" label="Enter URL" />
        <:actions>
          <.button phx-disable-with="Creating...">Create Link</.button>
        </:actions>
      </.simple_form>
    <% else %>
      <.short_link url={@url} link={@link} />
      <.button phx-click="create_new_link">Generate New Link</.button>
    <% end %>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:changeset, Links.change_link(%Link{}))
      |> assign(:show_result, false)

    {:ok, socket, layout: {ShortsUrlWeb.Layouts, :live}}
  end

  @impl true
  def handle_event("validate", %{"link" => link_params}, socket) do
    changeset =
      %Link{}
      |> Links.change_link(link_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"link" => link_params}, socket) do
    case Links.create_link(link_params) do
      {:ok, link} ->
        socket =
          socket
          |> assign(:changeset, Links.change_link(%Link{}))
          |> assign(:show_result, true)
          |> assign(:link, create_url_link(link))
          |> assign(:url, link.url)

        {:noreply,
         socket
         |> put_flash(:info, "Link created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("create_new_link", _params, socket) do
    {:noreply, assign(socket, :show_result, false)}
  end

  defp create_url_link(link) do
    "#{ShortsUrlWeb.Endpoint.url()}/#{link.key}"
  end


end
