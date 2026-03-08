require "rails_helper"
require "simplecov"

SimpleCov.start "rails" do
  minimum_coverage 80
  add_filter "/spec/"
end

RSpec.describe "Tasks API", type: :request do
  let(:valid_attrs) { { title: "Mi tarea", description: "Descripción", completed: false } }

  describe "GET /tasks" do
    it "retorna HTTP 200 y lista de tareas" do
      Task.create!(valid_attrs)
      get "/tasks"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an(Array)
    end
  end

  describe "POST /tasks" do
    it "crea una tarea con atributos válidos" do
      post "/tasks", params: { task: valid_attrs }
      expect(response).to have_http_status(:created)
    end

    it "rechaza una tarea sin título" do
      post "/tasks", params: { task: { title: "", completed: false } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /tasks/:id" do
    it "retorna la tarea cuando existe" do
      task = Task.create!(valid_attrs)
      get "/tasks/#{task.id}"
      expect(response).to have_http_status(:ok)
    end

    it "retorna 404 cuando no existe" do
      get "/tasks/99999"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /tasks/:id" do
    it "elimina la tarea" do
      task = Task.create!(valid_attrs)
      delete "/tasks/#{task.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
