Mix.Task.run "ecto.create", ~w(-r Zhora.Repo --quiet)
ExUnit.start
