ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Zhora.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Zhora.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Zhora.Repo)

