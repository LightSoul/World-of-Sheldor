class User < ActiveRecord::Base
  is_gravtastic!
  
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_many :links, :foreign_key => "user1_id", :class_name => "Relationship", :dependent => :destroy
  has_many :reverse_links, :foreign_key => "user2_id", :class_name => "Relationship", :dependent => :destroy

  has_many :friends, :through => :links, :source => "user2", :conditions => {"relationships.pending" => false }
  has_many :pending_out, :through => :links, :source => "user2",:conditions => {"relationships.pending" => true }
  has_many :pending_in, :through => :reverse_links, :source => "user1", :conditions => {"relationships.pending" => true }

  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :name, :email, :password
  validates_length_of   :name, :maximum => 50
  validates_format_of   :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
  
  # Automatically create the virtual attribute 'password_confirmation'.
  validates_confirmation_of :password

  # Additional password validations.
  validates_length_of   :password, :within => 6..40
  
  before_save :encrypt_password

  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}")
    save_without_validation
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private
    def encrypt_password
      unless password.nil?
        self.salt = make_salt
        self.encrypted_password = encrypt(password)
      end
    end

    def encrypt(string)
      secure_hash("#{salt}#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
