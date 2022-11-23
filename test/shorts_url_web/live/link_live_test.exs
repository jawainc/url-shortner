defmodule ShortsUrlWeb.LinkLiveTest do
  use ShortsUrlWeb.ConnCase

  import Phoenix.LiveViewTest
  import ShortsUrl.LinksFixtures

  @create_attrs %{url: "http://google.com"}
  @invalid_attrs %{url: nil}

  defp create_link(_) do
    link = link_fixture()
    %{link: link}
  end

  describe "Live" do
    setup [:create_link]

    test "lists all links", %{conn: conn, link: link} do
      {:ok, _index_live, html} = live(conn, ~p"/links/details")

      assert html =~ "Listing Links"
      assert html =~ link.key
    end

    test "saves new link", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/links/new")

      assert index_live
             |> form("#shortener-form", link: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      html =
        index_live
        |> form("#shortener-form", link: @create_attrs)
        |> render_submit()

      assert html =~ "Link created successfully"
      assert html =~ "http://google.com"
    end

    test "deletes link in listing", %{conn: conn, link: link} do
      {:ok, index_live, _html} = live(conn, ~p"/links/details")

      assert index_live |> element("#links-#{link.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#link-#{link.id}")
    end
  end
end
