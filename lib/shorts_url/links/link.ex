defmodule ShortsUrl.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :key, :string
    field :url, :string
    field :visit_count, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:key, :url, :visit_count])
    |> validate_required([:url])
    |> validate_url()
    |> unique_constraint(:key)
  end

  def validate_url(changeset) do
    validate_change changeset, :url, fn :url, value ->
      uri = URI.parse(value)
      case uri do
        %URI{scheme: nil} -> [url: "is missing a scheme (e.g. https)"]
        %URI{host: nil} -> [url: "is missing a host"]
        _ -> []
      end

    end
  end
end
