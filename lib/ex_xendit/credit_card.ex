defmodule ExXendit.CreditCard do
  @moduledoc """
  Handles functions at https://developers.xendit.co/api-reference/#credit-cards
  """
  alias ExXendit

  @doc """
  Create a charge to the credit card

  ## Body Parameters
    * `:token_id`* - The token ID used to charge the card  

    * `:authentication_id`* - Authentication ID for authenticating charge. Optional only if charge was already authenticated with a single-use token, or if optional authentication is enabled for your account.  

    * `:capture`* - Whether or not to capture immediately. Set to false to issue an authorization (hold funds) only, to be captured later with the capture endpoint. Default to true. 

    * `:reference_id`* - Reference ID provided by merchant (255 characters)  

    * `:currency`* - Currency used for the transaction in ISO4217 format - IDR, PHP, VND, THB 

    * `:amount`* - Amount that expected to be charged.

    * `:descriptor` - Specific descriptor to define merchant's identity.

      For aggregator merchant, it will always return XDT*[MERCHANT_NAME]-DESCRIPTOR
      For switcher merchant, it will always return [MERCHANT_NAME]-DESCRIPTOR
      
    * `:mid_label`* - Specific string value which labels any of your Merchant IDs (MID) set up with Xendit. This can be configured in the list of MIDs on your Dashboard settings. (If this is not included in a request, and you have more than 1 MID in your list, the transaction will proceed using your prioritized MID (first MID on your list)).

      Note:
      Only available in the response for switcher merchant

    * `:billing_details` - Billing details of the cardholder. If entered, should correspond with billing details registered by cardholder with their issuer. Required for a card to be verified by the Address Verification System (AVS) - only for USA / Canadian / Great Britain cards.

    * `:metadata` - A free-format JSON for additional information that you want to provide in the request.

    * `:promotion` - If you want to apply a Promotion to a charge, you must input these parameters.

    * `:installment` - These parameters are required to mark a transaction as an installment.
  """
  @spec create_charge(map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def create_charge(params, headers \\ %{}) do
    if headers != %{} do
      "credit_card_charges"
      |> ExXendit.post(params, headers)
    else
      "credit_card_charges"
      |> ExXendit.post(params)
    end
  end

  @doc """
  Capture charge 

  Capturing a charge only needed if you do pre-authorization by specifying capture to false in create charge request. You can capture a charge with amount different than authorized amount as long as it's less than authorized amount. Response for this endpoint is the same as create charge response

  ## Path Parameters
    * `:create_charge_id`* - Charge ID of authorization  

  ## Body Parameters
    * `:amount`* - Amount to be captured. Can be up to amount of authorization but not more
  """
  @spec capture_charge(String.t(), map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def capture_charge(charge_id, params, headers \\ %{}) do
    if headers != %{} do
      "credit_card_charges/#{charge_id}/capture"
      |> ExXendit.post(params, headers)
    else
      "credit_card_charges/#{charge_id}/capture"
      |> ExXendit.post(params)
    end
  end

  @doc """
  Create refund

  The Refund API accepts two parameters, amount and external_id. The charge ID, which is returned after a successful charge, must be used in request URL per the definition. Several partial refund calls can be made, so long as the total amount refunded is not greater than the total charge amount.

  ## Path Parameters
    * `:create_charge_id`* - Charge ID of authorization  

  ## Body Parameters
    * `:amount` - The amount to be refunded.

    * `:external_id` - A unique identifier of your choice. Max 64 characters.

  """
  @spec create_refund(String.t(), map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def create_refund(charge_id, params, headers \\ %{}) do
    if headers != %{} do
      "credit_card_charges/#{charge_id}/refund"
      |> ExXendit.post(params, headers)
    else
      # coveralls-ignore-start
      "credit_card_charges/#{charge_id}/refund"
      |> ExXendit.post(params)

      # coveralls-ignore-stop
    end
  end

  @doc """
  Get charge

  This is endpoint to get a charge object. You need to specify the id in the query parameter which you can choose between charge to use charge_id and external to use the external id / reference provided in your create charge request. Response for this endpoint is the same as create charge response

  ## Path Parameters
    * `:create_charge_id`* - Charge ID of authorization  

  ## Body Parameters
    * `:id_type` - Defined in [ID Types] (#id-types). If not filled, value will use charge by default. ID Types are: 

    charge - Use charge ID provided by xendit which can be retrieved from the charge response to retrieve the transaction detail (default value)

    external - Use external ID submitted by the user during charge / authorization request to retrieve the transaction detail

  """
  @spec get_charge(String.t(), map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def get_charge(charge_id, params, headers \\ %{}) do
    if headers != %{} do
      "credit_card_charges/#{charge_id}"
      |> ExXendit.get(params, headers)
    else
      # coveralls-ignore-start
      "credit_card_charges/#{charge_id}"
      |> ExXendit.get(params)

      # coveralls-ignore-stop
    end
  end
end
