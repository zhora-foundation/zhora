defmodule Zhora.Notice.Backtrace do
  use Zhora.Web, :entity

  @primary_key false

  schema "embedded Model" do
    field :file, :string
    field :method, :string
    field :number, :string
  end

  @required_fields ~w(file method number)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    cast(model, params, @required_fields, @optional_fields)
  end
end
