class Booking < ActiveRecord::Base

  belongs_to :user

  attr_accessor :current_user

  validates_presence_of :date, :hour

  validate :ownership, on: [:update]
  validate :not_past, on: [:create, :update]

  before_destroy :ownership #Nao funciona
  before_destroy :not_past #Nao funciona

  scope :order_by_date, -> { order(:date, :hour) }
  scope :in_range, ->(x) { where('date BETWEEN ? AND ?', x, x + 5.day)}

  private

  def ownership
    errors.add(:user, 'Não poder alterar/excluir a reserva de outro usuário') if user != current_user
  end

  def not_past
    errors.add(:date, 'Não é possível criar/alterar/excluir uma reserva com data passada') if date.past?
  end

end


