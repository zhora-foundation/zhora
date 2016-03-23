defmodule Zhora.Metric do
  use Zhora.Web, :model

  alias Zhora.Project

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "metrics" do
    belongs_to :project, Project

    field :metrics, :map
    field :environment, :string
    field :hostname, :string

    timestamps updated_at: false
  end

  @required_fields ~w(project_id metrics environment hostname)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    cast(model, params, @required_fields, @optional_fields)
  end
end
