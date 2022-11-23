defmodule ShortsUrl.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ShortsUrl.Links` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        "url" => "http://google.com"
      })
      |> ShortsUrl.Links.create_link()

    link
  end
end
