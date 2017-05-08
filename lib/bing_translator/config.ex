defmodule BingTranslator.Config do
  @moduledoc """
  Configuration State
  """

  defmodule Cfg do
    @moduledoc "Cfg struct"
    defstruct subscription_key: nil, http_client_options: [], token: nil, expires_in: nil
  end

  def configure do
    start_link(%Cfg{
      subscription_key: Application.get_env(:bing_translator, :subscription_key) || System.get_env("BING_TRANSLATOR_SUBSCRIPTION_KEY"),
      http_client_options: Application.get_env(:bing_translator, :http_client_options) || System.get_env("BING_TRANSLATOR_HTTP_CLIENT_OPTIONS") || []
    })
  end

  @doc """
  Set OAuth configuration values and initialise the process
  """
  def configure(subscription_key) do
    start_link(%Cfg{
      subscription_key: subscription_key,
      http_client_options: Application.get_env(:bing_translator, :http_client_options) || System.get_env("BING_TRANSLATOR_HTTP_OPTIONS") || []
    })
  end

  @doc """
  Set OAuth configuration values and initialise the process
  """
  def configure(subscription_key, http_client_options) do
    start_link(%Cfg{subscription_key: subscription_key, http_client_options: http_client_options})
  end

  @doc """
  Set a access token (associated with a user, rather than an application)
  """
  def set_token(token) do
    set(:token, token)
  end

  def get do
    Agent.get(__MODULE__, fn config -> config end)
  end

  def set(key, value) do
    Agent.update(__MODULE__, fn config ->
      Map.update!(config, key, fn _ -> value end)
    end)
  end

  def update(overwrite) do
    Enum.each overwrite, fn {key, value} ->
      set(key, value)
    end
  end

  def start_link do
    configure()
  end
  defp start_link(value) do
    Agent.start_link(fn -> value end, name: __MODULE__)
  end
end
