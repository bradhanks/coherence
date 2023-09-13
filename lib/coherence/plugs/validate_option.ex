defmodule Coherence.ValidateOption do
  @moduledoc """
  Plug to validate the given option is enabled in the project's configuration.
  """

  import Coherence.Controller, only: [logged_out_url: 1]
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  alias Coherence.Messages

  @behaviour Plug

  @spec init(keyword() | atom) :: map()
  def init(options) do
    %{option: options}
  end

  @spec call(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def call(conn, opts) do
    if Coherence.Config.has_option(opts[:option]) do
      conn
    else
      conn
      |> put_flash(:error, Messages.backend().invalid_request())
      |> redirect(to: logged_out_url(conn))
      |> halt
    end
  end
end
