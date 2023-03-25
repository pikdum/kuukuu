defmodule Kuukuu.ForumFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kuukuu.Forum` context.
  """

  @doc """
  Generate a thread.
  """
  def thread_fixture(attrs \\ %{}) do
    {:ok, thread} =
      attrs
      |> Enum.into(%{
        author: "some author",
        data: "some data",
        subject: "some subject"
      })
      |> Kuukuu.Forum.create_thread()

    thread
  end
end
