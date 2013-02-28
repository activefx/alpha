if configatron.stripe.enabled == true
  Stripe.api_key = configatron.stripe.live_api_key
  STRIPE_PUBLIC_KEY = configatron.stripe.live_public_key
else
  Stripe.api_key = configatron.stripe.test_api_key
  STRIPE_PUBLIC_KEY = configatron.stripe.test_public_key
end
