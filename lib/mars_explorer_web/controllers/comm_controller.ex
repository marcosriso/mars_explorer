defmodule MarsExplorerWeb.CommController do
  use MarsExplorerWeb, :controller

  def receive(conn, _params) do

    msg = %{:redrover => "1 3 N", :bluerover => "5 1 E"}
    json conn, msg
  end
end