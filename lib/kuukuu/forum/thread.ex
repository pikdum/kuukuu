defmodule Kuukuu.Forum.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :author, :string
    field :data, :string
    field :subject, :string
    field :parent_id, :id
    field :reply_count, :integer, virtual: true
    field :bumptime, :date, virtual: true

    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:subject, :author, :data])
    |> validate_required([:subject, :author, :data])
  end
end
