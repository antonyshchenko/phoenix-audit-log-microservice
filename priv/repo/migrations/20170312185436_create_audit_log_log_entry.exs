defmodule BusinessAuditLog.Repo.Migrations.CreateBusinessAuditLog.AuditLog.LogEntry do
  use Ecto.Migration

  def change do
    create table(:audit_log_entries) do
      add :actor_id, :string
      add :actor_type, :string
      add :action, :string
      add :resource_id, :string
      add :resource_type, :string

      timestamps()
    end

  end
end
