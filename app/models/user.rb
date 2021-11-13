class User < ApplicationRecord
    before_save { self.email = email.downcase if email }
    has_many :articles, dependent: :destroy
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
    validates :email, presence: true, 
        uniqueness: { case_sensitive: false }, 
        format:{ with:VALID_EMAIL_REGEX, multiline:true }, 
        length: { maximum: 80 }
    
    has_secure_password
end