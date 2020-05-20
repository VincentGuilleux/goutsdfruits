class Client < ApplicationRecord
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true
  validates :city, presence: true
  validates :segment, presence: true, inclusion: { in: %w(particulier magasin marché CE drive amap),
    message: "%{value} n'est pas un type de client valable" }
  validates :amap, :inclusion => { :in => ['Ine Boune Penerie', 'Bocageot', 'Asphodèle' ,'Court Circuiteurs'] }, :allow_nil => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.segments
    Client.all.map(&:segment).uniq.sort_by { |word| word.downcase }
  end
end
