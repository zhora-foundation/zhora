defmodule Zhora.Deflate do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case get_req_header(conn, "content-encoding") do
      ["deflate"] -> encode(conn)
      _ -> conn
    end
  end

  defp encode(conn) do
    case read_body(conn) do
      {:ok, content, conn} -> inflate(conn, content)
      _ -> conn
    end
  end

  defp inflate(conn, content) do
    zlib = :zlib.open
    :zlib.inflateInit(zlib)
    encoded = :zlib.inflate(zlib, content)
    :zlib.inflateEnd(zlib)

    case Poison.decode(encoded) do
      {:ok, json} -> %{conn | params: json}
      _ -> conn
    end
  end
end
