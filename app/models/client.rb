class Client < ApplicationRecord
  has_one_attached :avatar
  has_many :orders

  enum role: {client: 0, admin: 1}
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :client
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true
  validates :city, presence: true
  validates :segment, presence: true, inclusion: { in: %w(particulier magasin marché CE amap),
    message: "%{value} n'est pas un type de client valable" }
  validates :amap, :inclusion => { :in => ['Ine Boune Penerie', 'Bocageot', 'Asphodèle' ,'Court Circuiteurs'] }, :allow_nil => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.segments
    ["amap", "CE", "magasin", "marché", "particulier"]
  end

  def self.amap
    ['Ine Boune Penerie', 'Bocageot', 'Asphodèle' ,'Court Circuiteurs']
  end

end
