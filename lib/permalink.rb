require 'securerandom'

class Permalink < Sequel::Model
  def before_create
    self.permalink = SecureRandom.hex
  end
end
