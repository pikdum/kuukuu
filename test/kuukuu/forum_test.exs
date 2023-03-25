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

  describe "posts" do
    alias Kuukuu.Forum.Post

    import Kuukuu.ForumFixtures

    @invalid_attrs %{author: nil, data: nil, subject: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Forum.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Forum.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{author: "some author", data: "some data", subject: "some subject"}

      assert {:ok, %Post{} = post} = Forum.create_post(valid_attrs)
      assert post.author == "some author"
      assert post.data == "some data"
      assert post.subject == "some subject"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forum.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{author: "some updated author", data: "some updated data", subject: "some updated subject"}

      assert {:ok, %Post{} = post} = Forum.update_post(post, update_attrs)
      assert post.author == "some updated author"
      assert post.data == "some updated data"
      assert post.subject == "some updated subject"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Forum.update_post(post, @invalid_attrs)
      assert post == Forum.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Forum.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Forum.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Forum.change_post(post)
    end
  end
end
