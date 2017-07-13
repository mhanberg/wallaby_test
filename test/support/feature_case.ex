defmodule WallabyTest.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias WallabyTest.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import WallabyTest.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WallabyTest.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(WallabyTest.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(WallabyTest.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
