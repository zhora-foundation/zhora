defmodule Zhora.Notice.Request do
  use Zhora.Web, :entity

  embedded_schema do
    field :action, :string
    field :cgi_data, :map
    field :component, :string
    field :context, :string
    field :params, :map
    field :session, :map
    field :url, :string
  end

  @required_fields ~w(cgi_data url params session)
  @optional_fields ~w(action component context)

  def changeset(model, params \\ :empty) do
    cast(model, params, @required_fields, @optional_fields)
  end
end
