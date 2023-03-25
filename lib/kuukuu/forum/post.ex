defmodule Kuukuu.Forum.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :author, :string
    field :data, :string
    field :subject, :string
    field :parent_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:author, :data, :parent_id, :subject])
    |> validate_required([:author, :data])
  end
end
