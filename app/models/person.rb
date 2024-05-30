# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :family

  has_many :relationships, dependent: :destroy
  has_many :linked_people, through: :relationships, source: :linked_person
end
