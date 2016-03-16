defmodule Zhora.TestHelpers do
  alias Zhora.Repo
  alias RethinkDB.Query, as: Q

  def clean_repos(repos) do
    Enum.each(repos, fn repo ->
      Q.table(repo_table_name(repo))
      |> Q.delete
      |> Repo.run
    end)
  end

  defp repo_table_name(repo) do
    struct(repo).__meta__.source |> elem(1)
  end
end
