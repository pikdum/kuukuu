defmodule Kuukuu.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :subject, :string
      add :author, :string
      add :data, :string
      add :parent_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create index(:posts, [:parent_id])
  end
end
