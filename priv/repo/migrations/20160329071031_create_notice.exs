defmodule Zhora.Repo.Migrations.CreateNotice do
  use Ecto.Migration

  def change do
    create table(:notices)
  end
end
