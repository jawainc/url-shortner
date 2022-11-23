defmodule ShortsUrlWeb.PageControllerTest do
  use ShortsUrlWeb.ConnCase

  alias ShortsUrl.Links

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Create Link"
  end

  describe "Links Redirect" do
    import ShortsUrl.LinksFixtures

    test "test bad key", %{conn: conn} do
      conn = get(conn, ~p"/bad-key")
      assert redirected_to(conn) == ~p"/"
      assert %{"error" => _error} = conn.assigns.flash
    end
    test "test success redirect", %{conn: conn} do
      {:ok, link} = Links.create_link(%{"url" => "http://google.com"})
      conn = get(conn, ~p"/#{link.key}")
      assert redirected_to(conn, 302) == "http://google.com"
    end
  end

end
