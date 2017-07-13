ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(WallabyTest.Repo, :manual)

Application.put_env(:wallaby, :base_url, WallabyTest.Endpoint.url)
{:ok, _} = Application.ensure_all_started(:wallaby)
