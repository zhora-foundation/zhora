defmodule Zhora.MetricsParser do
  def parse(metrics) do
    List.foldl(metrics, %{}, &parse_acc/2)
  end

  defp parse_acc(_, {:error, reason} = error), do: error
  defp parse_acc(metric, acc) do
    case String.split(metric) do
      [key, value] ->
        case Float.parse(value) do
          {float, _} ->
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
          :error ->
            {:error, "malformed value"}
        end
      _ ->
        {:error, "malformed metric"}
    end
  end
end
