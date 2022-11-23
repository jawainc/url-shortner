defmodule ShortsUrl.LinksTest do
  use ShortsUrl.DataCase

  alias ShortsUrl.Links

  describe "links" do
    alias ShortsUrl.Links.Link

    import ShortsUrl.LinksFixtures

    @valid_attrs %{"url" => "http://google.com"}
    @invalid_attrs %{"url" => nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Links.list_links() == [link]
    end

    test "get_link!/1 returns the link with given key" do
      link = link_fixture()
      assert Links.get_link!(link.key) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Links.create_link(@valid_attrs)
      assert link.url == @valid_attrs["url"]
      assert link.visit_count == 0
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(@invalid_attrs)
    end

    test "increment link visit count" do
      link = link_fixture()

      assert {:ok, %Link{} = link} = Links.increment_count(link)
      assert link.visit_count == 1
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Links.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!(link.key) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Links.change_link(link)
    end
  end
end
