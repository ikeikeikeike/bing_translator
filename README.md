# Bing Translator, Microsoft Translator

[![Build Status](http://img.shields.io/travis/ikeikeikeike/bing_translator.svg?style=flat-square)](http://travis-ci.org/ikeikeikeike/bing_translator)
[![Hex version](https://img.shields.io/hexpm/v/bing_translator.svg "Hex version")](https://hex.pm/packages/bing_translator)
[![Hex downloads](https://img.shields.io/hexpm/dt/bing_translator.svg "Hex downloads")](https://hex.pm/packages/bing_translator)
[![Code Climate](http://img.shields.io/badge/code_climate-Erlang_17.4-brightgreen.svg?style=flat-square)](https://travis-ci.org/ikeikeikeike/bing_translator)

A simple Elixir interface to Azure's translation API

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

### Add bing_translator to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:bing_translator, "~> 1.0"}]
end
```

### Ensure bing_translator is started before your application:

```elixir
def application do
  [applications: [:bing_translator]]
end
```

#### Getting a Subscription Key

To sign up for the free tier (as of this writing), do the following:

- Text Translator is [here](http://docs.microsofttranslator.com/text-translate.html)
- Speech Translator is [here](http://docs.microsofttranslator.com/speech-translate.html)

### Usage

```elixir
spanish = BingTranslator.translate(text: "Hello. This will be translated!", from: "en", to: "es")

# without :from for auto language detection
spanish = BingTranslator.translate(text: "Hello. This will be translated!", to: "es")

locale = BingTranslator.detect(text: "Hello. This will be translated!") # => "en"
languages = BingTranslator.supported_language_codes # => ["ar", "bs-Latn", "bg", "ca", "zh-CHS",,,,,]

# The speak method calls a text-to-speech interface in the supplied language.
# It does not translate the text. Format can be 'audio/mp3' or 'audio/wav'

audio = BingTranslator.speak(text: "Hello. This will be spoken!", language: :en, format: "audio/mp3", options: "MaxQuality")
```

### Configuration

The default behaviour is to configure using the application environment:

In config/config.exs, add:

```elixir
config :bing_translator,
  subscription_key: "Your-Subscription-Key",
  http_client_options: []  #  [ssl: [{:versions, [:"tlsv1.2"]}]]
```

Or using environment variable
```shell
BING_TRANSLATOR_SUBSCRIPTION_KEY=Your-Subscription-Key mix run
```

### Documentation

[API Reference](http://hexdocs.pm/bing_translator/api-reference.html).
