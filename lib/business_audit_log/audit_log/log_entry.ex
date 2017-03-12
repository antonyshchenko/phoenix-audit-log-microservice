defmodule BusinessAuditLog.AuditLog.LogEntry do
  use Ecto.Schema
  
  schema "audit_log_entries" do
    field :actor_id, :string
    field :actor_type, :string
    field :action, :string
    field :resource_id, :string
    field :resource_type, :string

    timestamps()
  end
end
