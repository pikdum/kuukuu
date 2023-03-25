defmodule KuukuuWeb.ThreadLive.Index do
  use KuukuuWeb, :live_view

  alias Kuukuu.Forum
  alias Kuukuu.Forum.Thread

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Forum.subscribe()
    {:ok, stream(socket, :threads, Forum.list_threads())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Thread")
    |> assign(:thread, Forum.get_thread!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Thread")
    |> assign(:thread, %Thread{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Threads")
    |> assign(:thread, nil)
  end

  @impl true
  def handle_info({KuukuuWeb.ThreadLive.FormComponent, {:saved, thread}}, socket) do
    {:noreply, stream_insert(socket, :threads, thread, at: 0)}
  end

  def handle_info({:thread_created, thread}, socket) do
    {:noreply, stream_insert(socket, :threads, thread, at: 0)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    thread = Forum.get_thread!(id)
    {:ok, _} = Forum.delete_thread(thread)

    {:noreply, stream_delete(socket, :threads, thread)}
  end
end
