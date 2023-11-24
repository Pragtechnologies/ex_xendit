defmodule ExXendit.Payout do
  @moduledoc """
  Handles functions at https://developers.xendit.co/api-reference/#ewallets
  """
  alias ExXendit

  @doc """
  Creates a payout request

  ## Headers Parameters
    * `:idempotency_key`* - A unique key to prevent processing duplicate requests. Can be your reference_id or any GUID. Must be unique across development & production environments.  

    * `:sub_account_id` - The sub-account user-id that you want to make this transaction for.  

  ## Request Parameters
    * `:reference_id`* - A client defined payout identifier. This is the ID assigned to the payout on your system, such as a transaction or order ID. Does not need to be unique.  

    * `:channel_code`* - Channel code of destination bank, e-wallet or OTC channel. 

    * `:channel_properties`* - A container for properties associated with the chosen channel_code.

      ## Parameters
      * `:account_holder_name` - Name of account holder as per the bank or e-wallet’s records. Needs to match the registered account name exactly.

      * `:account_number` - Account number of destination. Mobile numbers for e-wallet accounts.

      * `:account_type` - Account type of the destination for currencies and channels that supports proxy transfers (ie: Using mobile number as account number)

    * `:currency`* - Currency used for the transaction in ISO4217 format - IDR, PHP, VND, THB 

    * `:amount`* - Amount to be sent to the destination account. Should be a multiple of the minimum increment for the selected channel.

      For IDR currency, number should be integer
      For PHP currency, number can be up to 2 decimal places

    * `:description` - Description to send with the payout. The recipient may see this e.g., in their bank statement (if supported) or in email receipts we send on your behalf.

    * `:receipt_notificaton` - Object containing email addresses to receive payout details upon successful payout. Maximum of three email addresses each.

      ## Parameters
      * `:email_to` - Direct email recipients

      * `:email_cc` - CC-ed email recipients

      * `:email_bcc` - BCC-ed email recipients


    * `:metadata` - Object of additional information you may use

  """
  @spec create(map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def create(params, headers) do
    "v2/payouts"
    |> ExXendit.post(params, headers)
  end
end
