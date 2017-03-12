defmodule BusinessAuditLog.AuditLog.SqsListener.Worker do
  use GenServer
  require Logger
  alias BusinessAuditLog.AuditLog

  def start_link(queue_name, opts \\ []) do
    case GenServer.start_link(__MODULE__, queue_name, opts) do
      {:ok, pid} ->
        GenServer.cast(pid, :receive_message)
        {:ok, pid}
      {:error, error} -> {:error, error}
    end
  end

  def handle_cast(:receive_message, queue_name) do
    receive_and_process_messages(queue_name)
    GenServer.cast(self(), :receive_message)
    {:noreply, queue_name}
  end

  defp receive_and_process_messages(queue_name) do
    log(:debug, "pulling messages")

    case ExAws.SQS.receive_message(queue_name) |> ExAws.request do
      {:ok, resp} -> process_messages(queue_name, resp[:body][:messages])
      {:error, error} -> log(:error, "failed to pull messages, error: #{inspect(error)}")
    end
  end

  defp process_messages(queue_name, messages) do
    Enum.each(messages, fn message -> process_message(queue_name, message) end)
  end

  defp process_message(queue_name, message) do
    with {:ok, parsed_message} <- parse_message(message),
         {:ok, parsed_message} <- process_parsed_message(parsed_message),
         {:ok, _} <- delete_message(queue_name, parsed_message)
    do
      {:ok, message}
    else
      {:error, reason} ->
        log(:error, "failed to process message #{inspect(message)}, reason: #{reason}")
        {:error, "failed to process message"}
    end
  end

  defp parse_message(%{body: body, receipt_handle: receipt_handle}) do
    case Poison.Parser.parse(body) do
      {:ok, parsed_body} -> {:ok, %{parsed_message: parsed_body, receipt_handle: receipt_handle}}
      {:error, error} -> {:error, "failed to parse message, parsing error: #{inspect(error)}"}
    end
  end

  defp process_parsed_message(%{parsed_message: parsed_message} = message) do
    log(:debug, "processing parsed message #{inspect(message)}")

    case AuditLog.create_log_entry(parsed_message["payload"]) do
      {:ok, _} -> {:ok, message}
      {:error, error} -> {:error, "failed to create log entry due to #{inspect(error)}"}
    end
  end

  defp delete_message(queue_name, %{parsed_message: _, receipt_handle: receipt_handle}) do
    log(:debug, "deleting message #{receipt_handle}")

    ExAws.SQS.delete_message(queue_name, receipt_handle) |> ExAws.request
  end

  defp log(level, message) do
    Logger.bare_log(level, "SQS listener #{inspect(self())}: #{message}")
  end
end

