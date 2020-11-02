class Advertisement < ApplicationRecord
  # has_and_belongs_to_many :companies

  scope :by_company, lambda { |company|
    where.not(id: company.blocked_advertisements.map(&:id))
  }
end
