class TaskSerializer < ActiveModel::Serializer

  attributes :id, :name, :priority, :due_date

  belongs_to :user
  def due_date
    object.due_date.strftime('%A, %b %d')
  end
end
