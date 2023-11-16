defmodule ExXendit.Transaction do
  @moduledoc """
  Handles functions at https://developers.xendit.co/api-reference/#transactions
  """
  alias ExXendit

  @doc """
  List the transactions of your main or sub-account. Use `list/1` if you intend to use for main only.

  ## Request Parameters
    * `:types` - The type of the transactions that will be filtered. If not specified, all transaction type will be returned. 

      Available types:
      - DISBURSEMENT: The disbursement of money-out transaction.
      - PAYMENT: The payment that includes all variation of money-in transaction.
      - REMITTANCE_PAYOUT: The remittance pay-out transaction.
      - TRANSFER: The transfer transaction between xendit account. This can be transfer in or out.
      - REFUND: A refund transaction created to refund amount from money-in Transaction.

    * `:statuses` - The status of the transactions that will be filtered. If not specified, all transaction status will be returned. 
      
      Available status:
      - PENDING: The transaction is still pending to be processed. This refers to money out-transaction when the amount is still on hold.
      - SUCCESS: The transaction is successfully sent for money-out or already arrives on money-in.
      - FAILED: The transaction failed to send/receive.
      - VOIDED: The money-in transaction is voided by customer.
      - REVERSED: The transaction is reversed by Xendit.

    * `:channel_categories` - The channel of the transactions that will be filtered. If not specified, all transaction channel will be returned.

      For DISBURSEMENT and REMITTANCE_PAYOUT type, the available channel categories are BANK and CASH.
      For PAYMENT type, the available channel categories are CARDS, CARDLESS_CREDIT, DIRECT_DEBIT, EWALLET, PAYLATER, QR_CODE, RETAIL_OUTLET, VIRTUAL_ACCOUNT.
      For TRANSFER type, the available channel category is XENPLATFORM.

    * `:reference_id` - Reference that will be searched. Search by reference is case sensitive and can be partial match.

    * `:product_id` - Product_id that will be searched. Product_id search is an exact match and case sensitive.

    * `:account_identifier` - Account identifier that will be searched. Account identifier search is exact match case sensitive.

    * `:currency` - Currency to filter. 

      Ex. `PHP`, `IDR`, `USD`, `VND`, `THB`, `MYR`, Default: `IDR`

    * `:amount` - Transaction amount to search. This will be exact match. 

    * `:created_gte` - Start time of transaction by created date. If not specified will list all dates. 

    * `:created_lte` - End time of transaction by created date. If not specified will list all dates. 

    * `:updated_gte` - Start time of transaction by updated date. If not specified will list all dates. 

    * `:updated_lte` - End time of transaction by updated date. If not specified will list all dates. 

    * `:limit` - A limit on the number of transactions to be returned for each request. Default: `10`

    * `:after_id` - Id of the immediately previous item. Use this with links on the response for pagination.

    * `:before_id` - Id of the immediately following item.

  ## Response Parameters
    * `:data` - Returns an array of Transaction Object. Returns empty array when there is no result 

    * `:has_more` - Indicates whether there are more items to be queried with after_id of the last item from the current result.
      Use the links to follow to the next result. 

    * `:links` - The links to the next page based on HATEOAS if there is next result.

      The HATEOAS format are:
      `href`: URI of target, this will be to the next link.
      `rel`: The relationship between source and target. The value will be next.
      `method`: The HTTP method, the alue will be GET.

  ## Examples
      # Main Account
      iex> ExXendit.Transaction.list(%{currency: "PHP"})
      {:ok, %Req.Response{}}

      # Sub Account
      iex> ExXendit.Transaction.list(%{currency: "PHP"}, "<sub_account_id>")
      {:ok, %Req.Response{}}
  """

  @spec list(map(), ExXendit.sub_account_id()) :: {:ok, Req.Response.t()}
  def list(params, sub_account_id \\ "") do
    if sub_account_id != "" do
      "/transactions"
      |> ExXendit.get(sub_account_id, params)
    else
      "/transactions"
      |> ExXendit.get(params)
    end
  end

  @spec get(String.t(), ExXendit.sub_account_id()) :: {:ok, Req.Response.t()}
  def get(transaction_id, sub_account_id \\ "") do
    if sub_account_id != "" do
      "/transactions/#{transaction_id}"
      |> ExXendit.get(sub_account_id, nil)
    else
      "/transactions/#{transaction_id}"
      |> ExXendit.get(nil)
    end
  end
end
