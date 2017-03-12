defmodule BusinessAuditLog.Web.PageController do
  use BusinessAuditLog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
