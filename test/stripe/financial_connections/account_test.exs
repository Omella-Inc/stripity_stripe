defmodule Stripe.FinancialConnections.AccountTest do
  use Stripe.StripeCase, async: true

  test "is refreshable" do
    assert {:ok, %Stripe.FinancialConnections.Account{}} = Stripe.FinancialConnections.Account.retrieve("fca_id")
    assert_stripe_requested(:get, "/v1/financial_connections/accounts/fca_id/refresh?features[]=balance")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.FinancialConnections.Account{}} = Stripe.FinancialConnections.Account.retrieve("fca_id")
    assert_stripe_requested(:get, "/v1/financial_connections/accounts/fca_id")
  end
end
