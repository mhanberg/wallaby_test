# WallabyTest

I believe this app reproduces an issue I'm seeing with the [Wallaby](https://github.com/keathley/wallaby) integration-testing library in Elixir, where the contents of `localStorage` persist across test sessions. This is despite [PR #93](https://github.com/keathley/wallaby/pull/93) which intended to separate localStorage between phantomjs sessions.

## Versions

All the latest at this time:

- Erlang 20.0
- Elixir 1.4.5
- phoenix 1.2
- phantomjs 2.1.1
- wallaby 0.17.0

## Steps to Reproduce

I generated a brand new phoenix app with the default route going to `PageController.index`

On that page I have a bit of JavaScript that writes the contents of `localStorage` to the page, and then sets `'foo'` to `'bar'`:

```html
<script>
  const container = document.querySelector('#localstorage');
  const localstorageContents = "foo = " + localStorage.getItem('foo');
  container.innerText = localstorageContents;
  localStorage.setItem('foo', 'bar');
</script>
```

The idea being that if `localStorage` is empty, we can expect `foo = null` but if `foo` is set from a previous test run, we'll see `foo = bar`.

I set up Wallaby according to [the README](https://github.com/keathley/wallaby/blob/master/README.md#setup). My only departure from those instructions was not to add `async: true` to my tests, because in order to test `localStorage` persisting across tests I needed them to run serially.

Finally, I have two identical Wallaby feature tests that visit the index page and assert that `foo = null` was written to the page:

```elixir
IO.puts "session.id: #{session.id}"

session
|> visit("/")
|> assert_has(css("#localstorage", text: "foo = null"))
```

I also `puts` the session ID in order to confirm they're using different phantomjs sessoins. When run individually both tests pass:

```
steve@wallaby_test mix test test/features/page_one_test.exs
session.id: a1729160-67ae-11e7-8935-75b4a57c6225
.

Finished in 1.4 seconds
1 test, 0 failures

Randomized with seed 480326
steve@wallaby_test mix test test/features/page_two_test.exs
session.id: a58affd0-67ae-11e7-8fec-e7d5317a2964
.

Finished in 1.4 seconds
1 test, 0 failures

Randomized with seed 279952
```

But when run together with `mix test test/features`, the second fails, presumably because the page contains `foo = bar` from the previous session's `localStorage.set`, and not the expected `foo = null`:

```
steve@wallaby_test mix test test/features
session.id: a9911ec0-67ae-11e7-9d90-15727110d3bb
.session.id: a9acbd10-67ae-11e7-9d90-15727110d3bb


  1) test localstorage is empty a the start of the test (WallabyTest.PageOneTest)
     test/features/page_one_test.exs:6
     ** (Wallaby.ExpectationNotMet) Expected to find 1, visible element that matched the css '#localstorage' but 0, visible elements were found.

     stacktrace:
       test/features/page_one_test.exs:11: (test)

Finished in 4.4 seconds
2 tests, 1 failure
```
