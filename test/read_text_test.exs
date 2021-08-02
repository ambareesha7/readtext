defmodule ReadTextTest do
  use ExUnit.Case
  doctest ReadText

  test "greets the world" do
    assert ReadText.replace_text(%{
             name: "John",
             company: "Google",
             time: "3:30pm",
             salesguy: "Ralph"
           }) ==
             "Hi John,\nThank you for your time in our office.\nThanks for booking at Google for 3:30pm\nRegards\nRalph\n"
  end
end
