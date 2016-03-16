defmodule Zhora.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users)
  end
end
