defmodule ShortsUrlWeb.PageController do
  use ShortsUrlWeb, :controller

  alias ShortsUrl.Links

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def redirect_short(conn, %{"key" => key}) do
    link = Links.get_link!(key)
    Task.start(Links, :increment_count, [link])
    redirect(conn, external: link.url)

    rescue
      _error ->
        conn
        |> put_flash(:error, "Invalid link")
        |> redirect(to: "/")
  end
end
