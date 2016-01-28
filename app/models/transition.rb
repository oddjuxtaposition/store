class Transition < ApplicationRecord
  belongs_to :stateful, polymorphic: true

  def readonly?
    true
  end
end
