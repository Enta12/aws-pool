defmodule TodolistWeb.JwtAuthPlug do
  import Plug.Conn
  alias Timemanager.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    case Token.verify_and_validate(jwt_from_cookie(conn)) do
      {:ok, claims} ->
        verify_tokens(conn, claims, xsrf_from_header(conn))

      {:error, _error} ->
        conn
        |> forbidden()
    end
  end

  defp verify_tokens(conn, %{"xsrf_token" => jwt_xsrf} = claims, xsrf) do
    if xsrf == jwt_xsrf do
      conn
      |> success(claims)
    else
      conn
      |> forbidden()
    end
  end

  defp xsrf_from_header(conn) do
    conn
    |> Plug.Conn.get_req_header("x-xsrf-token")
    |> List.first()
  end

  defp jwt_from_cookie(conn) do
    conn
    |> Plug.Conn.get_req_header("cookie")
    |> List.first()
    |> Plug.Conn.Cookies.decode()
    |> token_from_map(conn)
  end

  defp token_from_map(%{"session_jwt" => jwt}, _conn), do: jwt

  defp token_from_map(_cookie_map, conn) do
    conn
    |> forbidden
  end

  defp forbidden(conn) do
    conn
    |> put_status(:unauthorized)
    |> Phoenix.Controller.json(%{error: "Unauthorized access"})
    |> halt
  end

  defp success(conn, claims) do
    assign(conn, :claims, claims)
  end
end
