module Darp
  class DarpGenerator < ApplicationRecord
    validates_uniqueness_of :uuid
  end
end
