require Joken

defmodule Todolist.JwtAuthToken do
  def decode(jwt_string, public_key) do
   jwt_string
   |> Joken.token
   |> IO.puts
  end
end
