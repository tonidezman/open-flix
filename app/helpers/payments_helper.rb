module PaymentsHelper
  def cents_to_euros(cents)
    "#{cents / 100.0} €"
  end
end
