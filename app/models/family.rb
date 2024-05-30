# frozen_string_literal: true

class Family < ApplicationRecord
  has_many :people, dependent: :destroy

  validates :name, presence: true
end
