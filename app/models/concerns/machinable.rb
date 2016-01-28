module Machinable
  extend ActiveSupport::Concern

  included do
    has_many :transitions,
      as: :stateful,
      dependent: :delete_all
  end

  class_methods do
    def transition_class
      ::Transition
    end

  private
    def initial_state
      self::Machine.initial_state
    end
  end

  def machine
    @machine ||= begin
      self.class::Machine.new(self, transition_class: ::Transition)
    end
  end
end

