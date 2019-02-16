class Diary < ApplicationRecord
  attr_accessor :body
  paginates_per 3

  validates :date, presence: true, uniqueness: true
  validates :body, presence: true

  before_save do
    crypt = ActiveSupport::MessageEncryptor.new(key)
    self.encrypted_body = crypt.encrypt_and_sign(self.body)
  end

  after_find do
    crypt = ActiveSupport::MessageEncryptor.new(key)
    self.body = crypt.decrypt_and_verify(self.encrypted_body)
  end

  private

  def key
    Rails.application.secrets.secret_key_base.slice(0, 32)
  end
end
