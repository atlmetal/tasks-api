require "prometheus_exporter/middleware"
require "prometheus_exporter/instrumentation"
require "prometheus_exporter/server"

PrometheusExporter::Client.default = PrometheusExporter::LocalClient.new(
  collector: PrometheusExporter::Server::Collector.new
)

if defined?(Rails::Server)
  PrometheusExporter::Instrumentation::Process.start(
    type: "web",
    labels: { app: "tasks-api", environment: Rails.env }
  )
end
