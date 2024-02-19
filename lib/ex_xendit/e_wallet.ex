defmodule ExXendit.EWallet do
  @moduledoc """
  Handles functions at https://developers.xendit.co/api-reference/#ewallets
  """
  alias ExXendit

  @doc """
  Creates an e-wallet charge.

  ## Body Parameters
    * `:reference_id`* - Reference ID provided by merchant (255 characters)  

    * `:currency`* - Currency used for the transaction in ISO4217 format - IDR, PHP, VND, THB 

    * `:amount`* - Transaction amount to be paid

      Min - 1,000 for ID_JENIUSPAY and 100 IDR for all other eWallets or 1 PHP
      Max - based on eWallet holding limit 

    * `:checkout_method`* - Checkout method determines the payment flow used to process the transaction

      `ONE_TIME_PAYMENT` is used for single guest checkouts
      `TOKENIZED_PAYMENT` can be used for recurring payment
      
    * `:channel_code`* - Channel Code specifies which eWallet will be used to process the transaction - ID_OVO, ID_DANA, ID_LINKAJA, ID_SHOPEEPAY, ID_ASTRAPAY, ID_JENIUSPAY, ID_SAKUKU, PH_PAYMAYA, PH_GCASH, PH_GRABPAY, PH_SHOPEEPAY, VN_APPOTA, VN_MOMO, VN_SHOPEEPAY, VN_VNPTWALLET, VN_VIETTELPAY, VN_ZALOPAY, TH_WECHATPAY, TH_LINEPAY, TH_TRUEMONEY, TH_SHOPEEPAY

    * `:channel_properties`* - Channel specific information required for the transaction to be initiated

  """
  @spec create_charge(map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def create_charge(params, headers \\ %{}) do
    if headers != %{} do
      "ewallets/charges"
      |> ExXendit.post(params, headers)
    else
      "ewallets/charges"
      |> ExXendit.post(params)
    end
  end

  @doc """
  Creates an e-wallet refund.

  ## Path Parameters
    * `:id`* - Unique identifier for charge request transaction (returned as id in the eWallet Charge request)  

  ## Body Parameters
    * `:amount` - Amount to be refunded to your customer. Cumulative amount refunded must not exceed the original transacted amount. If the amount field is not present in the request body, the remaining unrefunded amount of the charge would be processed.

    * `:reason` - Reason for refund, one of the following values can be used.
    
      Available values: `DUPLICATE`, `FRAUDULENT`, `REQUESTED_BY_CUSTOMER`, `CANCELLATION`, `OTHERS`

  """
  @spec create_refund(String.t(), map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def create_refund(id, params, headers \\ %{}) do
    if headers != %{} do
      "ewallets/charges/#{id}/refunds"
      |> ExXendit.post(params, headers)
    else
      # coveralls-ignore-start
      "ewallets/charges/#{id}/refunds"
      |> ExXendit.post(params)

      # coveralls-ignore-stop
    end
  end
end
