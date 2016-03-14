defmodule Zhora.Repo do
  use Ecto.Repo, otp_app: :zhora,
    adapter: RethinkDB.Ecto
end
