defmodule Zhora.Repo.Migrations.AddProjectsTable do
  use Ecto.Migration

  def change do
    create table(:projects)
    create index(:projects, [:api_key])
  end
end
