class Day < ActiveRecord::Base

  #
  # Associations ----------------------------
  #
  belongs_to :user

  #
  # Validations -----------------------------
  #
  validates_presence_of :date, :user_id

end
