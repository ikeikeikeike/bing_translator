defmodule BingTranslator.Config do

  defmodule Cfg do
    defstruct client_id: nil, client_secret: nil, token: nil, skip_ssl_verify: nil
  end

  def configure do
    start_link(%Cfg{
      client_id: Application.get_env(:bing_translator, :client_id) || System.get_env("BING_TRANSLATOR_CLIENT_ID"),
      client_secret: Application.get_env(:bing_translator, :client_secret) || System.get_env("BING_TRANSLATOR_CLIENT_SECRET"),
      skip_ssl_verify: Application.get_env(:bing_translator, :skip_ssl_verify) || System.get_env("BING_TRANSLATOR_SKIP_SSL_VERIFY") || false
    })
    {:ok, []}
  end

  @doc """
  Set OAuth configuration values and initialise the process
  """
  def configure(client_id, client_secret) do
    start_link(%Cfg{
      client_id: client_id, 
      client_secret: client_secret, 
      skip_ssl_verify: Application.get_env(:bing_translator, :skip_ssl_verify) || System.get_env("BING_TRANSLATOR_SKIP_SSL_VERIFY") || false
    })
    {:ok, []}
  end

  @doc """
  Set OAuth configuration values and initialise the process
  """
  def configure(client_id, client_secret, skip_ssl_verify) do
    start_link(%Cfg{client_id: client_id, client_secret: client_secret, skip_ssl_verify: skip_ssl_verify})
    {:ok, []}
  end

  @doc """
  Set a access token (associated with a user, rather than an application)
  """
  def set_token(token) do
    set(:token, token)
  end

  # def set_expires_in(token) do
    # set(:expires_in, token)
  # end

  @doc """
  Get the configuration object
  """
  def get do
    Agent.get(__MODULE__, fn config -> config end)
  end

  defp set(key, value) do
    Agent.update(__MODULE__, fn config ->
      Map.update!(config, key, fn _ -> value end)
    end)
  end

  defp start_link(value) do
    Agent.start_link(fn -> value end, name: __MODULE__)
  end
end
