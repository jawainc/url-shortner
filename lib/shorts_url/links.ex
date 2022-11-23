defmodule ShortsUrl.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias ShortsUrl.Repo

  alias ShortsUrl.Links.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def list_links do
    Repo.all(Link)
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(key), do: Repo.get_by!(Link, key: key)

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs \\ %{}) do
    attrs = assign_random_key(attrs)

    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()

  rescue
    Ecto.ConstraintError -> create_link(attrs)
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{data: %Link{}}

  """
  def change_link(%Link{} = link, attrs \\ %{}) do
    Link.changeset(link, attrs)
  end

  @doc """
  Increment visit count.

  ## Examples

      iex> increment_count(link)
      {:ok, %Link{}}

  """
  def increment_count(link) do
    update_link(link, %{visit_count: link.visit_count + 1})
  end

  defp assign_random_key(%{"key" => _key} = attrs) do
    attrs
    |> Map.drop(["key"])
    |> assign_random_key()
  end
  defp assign_random_key(attrs), do: Map.put(attrs, "key", random_string(8))

  defp random_string(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64()
    |> String.replace(~r/[-_\=]/, "")
    |> binary_part(0, length)
  end

end
