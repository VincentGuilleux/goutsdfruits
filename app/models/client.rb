class Client < ApplicationRecord
  has_one_attached :avatar
  has_many :orders

  enum role: {client: 0, admin: 1}
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :client
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :last_name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true
  validates :city, presence: true
  validates :segment, presence: true, inclusion: { in: %w(particulier magasin marché CE),
    message: "%{value} n'est pas un type de client valable" }
  validates :amap, :inclusion => { :in => ['Ine Boune Penerie', 'Bocageot', 'Asphodèle' ,'Court Circuiteurs', 'Non-membre'], message: "%{value} n'est pas un nom d'AMAP valable" }

  scope :new_clients_current_month, -> {where('extract(year from created_at) = ?', Date.today.year).where('extract(month from created_at) = ?', Date.today.month)}

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.segments
    ["CE", "magasin", "marché", "particulier"]
  end

  def self.segments_new_client
    ["magasin", "particulier"]
  end

  def self.amap
    ['Non-membre', 'Ine Boune Penerie', 'Bocageot', 'Asphodèle' ,'Court Circuiteurs']
  end

end
