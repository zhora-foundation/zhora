Mix.Task.run("ecto.setup", ~w(-r Zhora.Repo --quiet))
ExUnit.start
