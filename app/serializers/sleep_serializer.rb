class SleepSerializer < ActiveModel::Serializer
  attributes :id, :sleep_start, :sleep_end, :duration_seconds, :created_at, :updated_at
  belongs_to :user, serializer: UserSerializer
end
