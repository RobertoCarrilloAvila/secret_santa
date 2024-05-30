# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :family

  has_many :relationships, dependent: :destroy
  has_many :linked_people, through: :relationships, source: :linked_person

  has_many :given_gifts, class_name: 'GiftAssigment', foreign_key: 'giver_id', dependent: :destroy
  has_many :recipients, through: :given_gifts, source: :recipient

  has_many :received_gifts, class_name: 'GiftAssigment', foreign_key: 'recipient_id', dependent: :destroy
  has_many :givers, through: :received_gifts, source: :giver
end
