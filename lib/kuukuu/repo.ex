defmodule Kuukuu.Repo do
  use Ecto.Repo,
    otp_app: :kuukuu,
    adapter: Ecto.Adapters.SQLite3
end
