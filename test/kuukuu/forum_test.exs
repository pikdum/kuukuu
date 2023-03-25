defmodule Kuukuu.ForumTest do
  use Kuukuu.DataCase

  alias Kuukuu.Forum

  describe "threads" do
    alias Kuukuu.Forum.Thread

    import Kuukuu.ForumFixtures

    @invalid_attrs %{author: nil, data: nil, subject: nil}

    test "list_threads/0 returns all threads" do
      thread = thread_fixture()
      assert Forum.list_threads() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Forum.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      valid_attrs = %{author: "some author", data: "some data", subject: "some subject"}

      assert {:ok, %Thread{} = thread} = Forum.create_thread(valid_attrs)
      assert thread.author == "some author"
      assert thread.data == "some data"
      assert thread.subject == "some subject"
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forum.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()
      update_attrs = %{author: "some updated author", data: "some updated data", subject: "some updated subject"}

      assert {:ok, %Thread{} = thread} = Forum.update_thread(thread, update_attrs)
      assert thread.author == "some updated author"
      assert thread.data == "some updated data"
      assert thread.subject == "some updated subject"
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Forum.update_thread(thread, @invalid_attrs)
      assert thread == Forum.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Forum.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Forum.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Forum.change_thread(thread)
    end
  end
end
