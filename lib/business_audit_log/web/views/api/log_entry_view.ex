defmodule BusinessAuditLog.Web.Api.LogEntryView do
  use BusinessAuditLog.Web, :view
  alias BusinessAuditLog.Web.Api.LogEntryView

  def render("index.json", %{log_entries_page: entries_page}) do
    %{entries: render_many(entries_page.entries, LogEntryView, "log_entry.json"),
     page_number: entries_page.page_number,
     page_size: entries_page.page_size,
     total_pages: entries_page.total_pages,
     total_entries: entries_page.total_entries}
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
