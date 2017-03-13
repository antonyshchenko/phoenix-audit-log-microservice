defmodule BusinessAuditLog.Web.LogEntryController do
  use BusinessAuditLog.Web, :controller
  alias BusinessAuditLog.AuditLog

  def index(conn, _params) do
    entries = AuditLog.list_entries()
    render(conn, "index.html", entries: entries)
  end
end
