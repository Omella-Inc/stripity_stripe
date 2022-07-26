defmodule Stripe.FinancialConnections.Account do
  @moduledoc """
  Work with Stripe Financial Connections Account objects.

  A [FinancialConnectionsAccount](https://stripe.com/docs/api/financial_connections/accounts) represents
  an account that exists outside of Stripe, to which you have been granted some degree of access.

   You can:
  - [Refresh an account balance](https://stripe.com/docs/api/financial_connections/accounts/refresh)
  - [Retrieve an account details](https://stripe.com/docs/api/financial_connections/accounts/retrieve)
  """

  use Stripe.Entity
  import Stripe.Request
  require Stripe.Util

  @type account_holder :: %{
          account: String.t() | nil,
          customer: String.t() | nil,
          type: String.t()
        }

  @type cash :: %{
          available: %{
            usd: integer
          }
        }

  @type credit :: %{
          used: %{
            usd: integer
          }
        }

  @type current :: %{
          usd: integer
        }

  @type balance :: %{
          as_of: Stripe.timestamp(),
          cash: cash | nil,
          credit: credit | nil,
          current: current,
          type: String.t()
        }

  @type balance_refresh :: %{
          last_attempted_at: Stripe.timestamp(),
          status: String.t()
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          account_holder: account_holder | nil,
          balance: balance | nil,
          balance_refresh: balance_refresh | String.t(),
          category: String.t(),
          created: Stripe.timestamp(),
          display_name: String.t() | nil,
          institution_name: String.t() | nil,
          last4: String.t() | nil,
          livemode: boolean,
          ownership: map() | nil,
          ownership_refresh: map() | nil,
          permissions: list(String.t()) | nil,
          status: String.t() | nil,
          subcategory: String.t() | nil,
          supported_payment_method_types: list(String.t()) | nil
        }

  defstruct [
    :id,
    :object,
    :account_holder,
    :balance,
    :balance_refresh,
    :category,
    :created,
    :display_name,
    :institution_name,
    :last4,
    :livemode,
    :ownership,
    :ownership_refresh,
    :permissions,
    :status,
    :subcategory,
    :supported_payment_method_types
  ]

  @plural_endpoint "financial_connections/accounts"

  @doc """
  Refreshes the data associated with a Financial Connections.
  See the [Stripe docs](https://stripe.com/docs/api/financial_connections/accounts/refresh).
  """
  @spec refresh_balance(Stripe.id() | t, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def refresh_balance(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}" <> "/refresh?features[]=balance")
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieves the details of an Financial Connections.
  See the [Stripe docs](https://stripe.com/docs/api/financial_connections/accounts/retrieve).
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end
end
