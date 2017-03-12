defmodule BusinessAuditLog.Web.Api.LogEntryView do
  use BusinessAuditLog.Web, :view
  alias BusinessAuditLog.Web.Api.LogEntryView

  def render("index.json", %{entries: entries}) do
    %{data: render_many(entries, LogEntryView, "log_entry.json")}
  end

  def render("log_entry.json", %{log_entry: log_entry}) do
    %{id: log_entry.id,
      actor_id: log_entry.actor_id,
      actor_type: log_entry.actor_type,
      action: log_entry.action,
      resource_id: log_entry.resource_id,
      resource_type: log_entry.resource_type}
  end
end
