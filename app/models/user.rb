class User < ActiveRecord::Base
  has_many :variables
  has_and_belongs_to_many :devices
  has_many :created_devices
  validates_uniqueness_of :subdomain
  before_validation_on_create :generate_subdomain
  attr_protected :subdomain
  validates_uniqueness_of :subdomain

  def admin?
    self.role.eql? 'admin'
  end

  def generate_subdomain
    unless self[:subdomain]
      subdom = self[:username]
      subdom = self[:nickname] unless subdom
      subdom = $1 if not subdom and self[:email] =~ /^([^@]*).*$/
      subdom = 'unknown' unless subdom
      subdom.gsub! /\s+/, ''
      subdom = "#{subdom}_#{(Kernel.rand(1000)).to_i}"
      self[:subdomain] =  subdom
    end
  end

end
