defmodule BingTranslatorTest do
  use ExUnit.Case
  doctest BingTranslator

  setup_all do
    BingTranslator.configure("", "")
    :ok
  end

  test "It checks translate method" do
    assert BingTranslator.translate("", to: "en") == ""
  end

  test "It checks detect method" do
    assert BingTranslator.detect("") == ""
  end

  # test "It checks speak method" do
    # assert BingTranslator.speak("success", language: :en, format: "audio/mp3", options: "MaxQuality") == ""
  # end

  test "It checks supported_language_codes method" do
    assert BingTranslator.supported_language_codes() == []
  end

  test "It checks get_access_token! method" do
    assert BingTranslator.Translator.get_access_token! == []
  end

end
