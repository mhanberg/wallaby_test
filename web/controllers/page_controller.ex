defmodule WallabyTest.PageController do
  use WallabyTest.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
