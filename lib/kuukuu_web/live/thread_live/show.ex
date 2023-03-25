defmodule KuukuuWeb.ThreadLive.Show do
  use KuukuuWeb, :live_view

  alias Kuukuu.Forum
  alias Kuukuu.Forum.Post

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, stream(socket, :posts, Forum.list_posts(id))}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:thread, Forum.get_thread!(id))
     |> assign(:post, %Post{})}
  end

  defp page_title(:show), do: "Show Thread"
  defp page_title(:edit), do: "Edit Thread"
  defp page_title(:new), do: "New Reply"

  @impl true
  def handle_info({KuukuuWeb.ThreadLive.FormComponent, {:saved, post}}, socket) do
    {:noreply, socket}
  end

  def handle_info({KuukuuWeb.PostLive.FormComponent, {:saved, post}}, socket) do
    {:noreply, stream_insert(socket, :posts, post)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Forum.get_post!(id)
    {:ok, _} = Forum.delete_post(post)

    {:noreply, stream_delete(socket, :posts, post)}
  end
end
