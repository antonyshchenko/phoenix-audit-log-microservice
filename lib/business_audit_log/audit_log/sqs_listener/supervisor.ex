defmodule BusinessAuditLog.AuditLog.SqsListener.Supervisor do
  use Supervisor
  alias BusinessAuditLog.AuditLog.SqsListener
  alias BusinessAuditLog.AuditLog.SqsListener.Worker

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    # get queue name from config
    [queue: queue_name] = Application.get_env(:business_audit_log, SqsListener)

    children = [
      worker(Worker, [queue_name], id: "worker-1"),
      worker(Worker, [queue_name], id: "worker-2")
    ]

    supervise(children, strategy: :one_for_one)
  end
end


