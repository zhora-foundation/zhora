defmodule Zhora.Repo.Migrations.AddDeploysTable do
  use Ecto.Migration

  def change do
    create table(:deploys)
  end
end
