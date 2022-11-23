defmodule ShortsUrl.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :key, :string, null: false
      add :url, :string, null: false
      add :visit_count, :integer, default: 0

      timestamps()
    end

    create index(:links, [:key], unique: true)
  end
end
