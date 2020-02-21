class User < ApplicationRecord

    before_create { email.downcase! }
    has_secure_password
    validates :name, presence: true, length: { minimum: 2, maximum: 50 }, uniqueness: { case_sensitive: true }
    validates :email, presence: true, uniqueness: { case_sensitive: false } 
    validates :password, presence: true, length: { minimum: 6, maximum: 100 }

end
