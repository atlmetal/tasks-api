require 'prometheus_exporter/instrumentation'

if defined?(Rails::Server)
  PrometheusExporter::Instrumentation::Process.start(
    type: 'web',
    labels: { app: 'tasks-api', environment: Rails.env }
  )
end
