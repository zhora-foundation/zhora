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

    timestamps
  end

  @required_fields ~w(project_id metrics environment hostname)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def parse(metrics) do
    List.foldl(metrics, %{}, fn metric, acc ->
      [key, value] = String.split(metric)
      {float, _} = Float.parse(value)

      case String.split(key, ":", parts: 2) do
        [name] ->
          count = Map.get(acc, name, %{})
          count = Map.put(count, "count", float)
          Map.put(acc, name, count)
        [name, key] ->
          values = Map.get(acc, name, %{})
          values = Map.put(values, key, float)
          Map.put(acc, name, values)
      end
    end)
  end
end
