defmodule KuukuuWeb.ThreadLiveTest do
  use KuukuuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Kuukuu.ForumFixtures

  @create_attrs %{author: "some author", data: "some data", subject: "some subject"}
  @update_attrs %{author: "some updated author", data: "some updated data", subject: "some updated subject"}
  @invalid_attrs %{author: nil, data: nil, subject: nil}

  defp create_thread(_) do
    thread = thread_fixture()
    %{thread: thread}
  end

  describe "Index" do
    setup [:create_thread]

    test "lists all threads", %{conn: conn, thread: thread} do
      {:ok, _index_live, html} = live(conn, ~p"/forum")

      assert html =~ "Listing Threads"
      assert html =~ thread.author
    end

    test "saves new thread", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/forum")

      assert index_live |> element("a", "New Thread") |> render_click() =~
               "New Thread"

      assert_patch(index_live, ~p"/forum/new")

      assert index_live
             |> form("#thread-form", thread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#thread-form", thread: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/forum")

      html = render(index_live)
      assert html =~ "Thread created successfully"
      assert html =~ "some author"
    end

    test "updates thread in listing", %{conn: conn, thread: thread} do
      {:ok, index_live, _html} = live(conn, ~p"/forum")

      assert index_live |> element("#threads-#{thread.id} a", "Edit") |> render_click() =~
               "Edit Thread"

      assert_patch(index_live, ~p"/forum/#{thread}/edit")

      assert index_live
             |> form("#thread-form", thread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#thread-form", thread: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/forum")

      html = render(index_live)
      assert html =~ "Thread updated successfully"
      assert html =~ "some updated author"
    end

    test "deletes thread in listing", %{conn: conn, thread: thread} do
      {:ok, index_live, _html} = live(conn, ~p"/forum")

      assert index_live |> element("#threads-#{thread.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#threads-#{thread.id}")
    end
  end

  describe "Show" do
    setup [:create_thread]

    test "displays thread", %{conn: conn, thread: thread} do
      {:ok, _show_live, html} = live(conn, ~p"/forum/#{thread}")

      assert html =~ "Show Thread"
      assert html =~ thread.author
    end

    test "updates thread within modal", %{conn: conn, thread: thread} do
      {:ok, show_live, _html} = live(conn, ~p"/forum/#{thread}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Thread"

      assert_patch(show_live, ~p"/forum/#{thread}/show/edit")

      assert show_live
             |> form("#thread-form", thread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#thread-form", thread: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/forum/#{thread}")

      html = render(show_live)
      assert html =~ "Thread updated successfully"
      assert html =~ "some updated author"
    end
  end
end
