defmodule Zhora.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_json(msg) do
    %{"status" => "error", "reason" => msg}
  end
end
