defmodule Zhora.Repo.Migrations.CreateMetric do
  use Ecto.Migration

  def change do
    create table(:metrics)
  end
end
