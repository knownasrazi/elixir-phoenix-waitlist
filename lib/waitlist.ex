defmodule Waitlist do
  @moduledoc "Hand-crafted waitlist - simple Agent, no Ecto for demo"
  use Agent

  def start_link(_), do: Agent.start_link(fn -> [] end, name: __MODULE__)

  def join(email) when is_binary(email) do
    # Hand-crafted: check @
    if String.contains?(email, "@") do
      Agent.update(__MODULE__, fn list -> [email | list] end)
      {:ok, email}
    else
      {:error, "invalid email"}
    end
  end

  def count, do: Agent.get(__MODULE__, &length/1)
end
