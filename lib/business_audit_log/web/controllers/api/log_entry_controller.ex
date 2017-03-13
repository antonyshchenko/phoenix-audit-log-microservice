defmodule BusinessAuditLog.Web.Api.LogEntryController do
  use BusinessAuditLog.Web, :controller

  alias BusinessAuditLog.AuditLog
  alias BusinessAuditLog.AuditLog.LogEntry

  action_fallback BusinessAuditLog.Web.FallbackController

  def index(conn, %{"resource_type" => resource_type, "resource_id" => resource_id} = params) do
    log_entries_page = AuditLog.list_entries_by_resource(resource_type,
                                                         resource_id,
                                                         page: params["page"] || 1,
                                                         page_size: 10)
    render(conn, "index.json", log_entries_page: log_entries_page)
  end
end
