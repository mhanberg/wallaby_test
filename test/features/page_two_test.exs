defmodule WallabyTest.PageTwpTest do
  use WallabyTest.FeatureCase

  import Wallaby.Query, only: [css: 2]

  test "localstorage is empty a the start of another test", %{session: session} do
    IO.puts "session.id: #{session.id}"

    session
    |> visit("/")
    |> assert_has(css("#localstorage", text: "foo = null"))
  end
end
