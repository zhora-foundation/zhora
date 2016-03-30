defmodule Zhora.Notice.Server do
  use Zhora.Web, :entity

  @primary_key false

  schema "embedded Model" do
    field :environment_name, :string
    field :hostname, :string
    field :pid, :integer
    field :project_root, :string
    field :stats, :map
    field :time, :string
  end

  @required_fields ~w(environment_name hostname pid project_root stats time)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    cast(model, params, @required_fields, @optional_fields)
  end
end
