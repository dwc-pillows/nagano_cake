class Delivery < ApplicationRecord
  belongs_to :user

  def destination
    zip_code + " " + address + " " + name
  end
end
