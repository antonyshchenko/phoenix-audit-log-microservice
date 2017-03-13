defmodule BusinessAuditLog.Web.Router do
  use BusinessAuditLog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BusinessAuditLog.Web do
    # Use the default browser stack
    pipe_through :browser

    get "/", LogEntryController, :index
    get "/tail", LogEntryController, :tail
  end

  scope "/api", BusinessAuditLog.Web.Api, as: :api do
    pipe_through :api

    get "/entries/:resource_type/:resource_id", LogEntryController, :index
  end
end
