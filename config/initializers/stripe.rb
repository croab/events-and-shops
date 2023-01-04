# Stripe.api_key = ENV['STRIPE_API_SECRET']
Rails.configuration.stripe = {
  public: ENV['STRIPE_API_PUBLIC'],
  secret: ENV['STRIPE_API_SECRET']
}
Stripe.api_key = Rails.configuration.stripe[:secret]
p Stripe.api_key
