require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it 'es válida con atributos válidos' do
      task = described_class.new(title: 'Tarea', description: 'Desc', completed: false)
      expect(task).to be_valid
    end

    it 'requiere título' do
      task = described_class.new(title: nil, completed: false)
      expect(task).not_to be_valid
    end

    it 'requiere título con mínimo 3 caracteres' do
      task = described_class.new(title: 'ab', completed: false)
      expect(task).not_to be_valid
    end

    it 'requiere título con máximo 100 caracteres' do
      task = described_class.new(title: 'a' * 101, completed: false)
      expect(task).not_to be_valid
    end

    it 'requiere completed como booleano' do
      task = described_class.new(title: 'Tarea', completed: nil)
      expect(task).not_to be_valid
    end
  end

  describe 'scopes' do
    before do
      described_class.create!(title: 'Pendiente', completed: false)
      described_class.create!(title: 'Completada', completed: true)
    end

    it '.pending retorna tareas no completadas' do
      expect(described_class.pending.pluck(:title)).to eq(['Pendiente'])
    end

    it '.done retorna tareas completadas' do
      expect(described_class.done.pluck(:title)).to eq(['Completada'])
    end
  end
end
