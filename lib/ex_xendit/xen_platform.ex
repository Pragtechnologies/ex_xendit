defmodule ExXendit.XenPlatform do
  @moduledoc """
  Handles functions at https://developers.xendit.co/api-reference/#xenplatform
  """
  alias ExXendit

  @doc """
  Creates a sub-account.

  ## Request Parameters
    * `:email`* - Email identifier for the sub account  

    * `:type`* - Type of account you are creating 
      
      Available status:
      - MANAGED: Accounts provide your Partners with full-fledged Xendit Accounts that your Platform can transact on behalf of. Your Partners may register their Account via an invitation email is sent to the email. Thereafter, your Partners login to their own Xendit dashboard to complete the onboarding process.
      - OWNED: Accounts are invisible to your Partners and fully controlled by you. You may transact on behalf of an OWNED Account once they have been created using payment methods that have been enabled on your Platform.

    * `:public_profile` - Map that contains information that will be seen by end-payers or end-recipients (e.g. appears on hosted checkout page, credit card statements, etc.). Required if type is `OWNED`.

      ```
      %{business_name: "name of business"} 
      ```

  ## Response Parameters
    * `:id` - ID of your Account, use this in the for-user-id header to create transactions on behalf of your Account 

    * `:created` - Timestamp of when the account was created in UTC 

    * `:updated` - Timestamp of when the account was updated in UTC 

    * `:type` - The type of account created 

    * `:email` - Email identifier for the Account 

    * `:public_profile` - Contains information that will be seen by end-payers or end-recipients (e.g. appears on hosted checkout page, credit card statements, etc.). 

    * `:country` - The country (based on ISO 3166-1 Alpha-2) of incorporation for a business, or the country of residence for an individual. Default value: Your country of operation. 

    * `:status` - Status of the Account you are creating. 

      Available values: `INVITED`, `REGISTERED`, `AWAITING_DOCS`, `LIVE`

  ## Examples
      iex> ExXendit.XenPlatform.create_account(%{email: "a@a.com", type: "OWNED", public_profile: %{business_name: "test"}})
      {:ok, %Req.Response{}}

  """
  @spec create_account(map()) :: {:ok, Req.Response.t()}
  def create_account(params) do
    "v2/accounts"
    |> ExXendit.post(params)
  end

  @doc """
  Creates a transfer.

  ## Body Parameters
    * `:reference`* - A unique reference for this Transfer. Use this to reconcile transactions across your master and sub-accounts  

    * `:amount`* - The amount that you would like to transfer. No decimal point for IDR, and max 2 decimal points for PHP 
      
    * `:source_user_id`* - The account balance from which you would like to send the Transfer from. This can either be your platform or sub accounts user_id.

    * `:destination_user_id`* - The account balance from which you would like to send the Transfer to. This can either be your platform or sub accounts user_id.


  ## Response Parameters
    * `:created` - Timestamp of when the account was created in UTC 

    * `:transfer_id` - A unique reference for this Transfer set by Xendit systems 

    * `:reference` - A unique reference for this Transfer that you set when making the request 

    * `:source_user_id` - The source of the transfer. This is the user_id of either your master or sub account

    * `:destination_user_id` - The destination of the transfer. This is the user_id of either your master or sub account

    * `:status` - The status of the Transfer 

      Available values: `SUCCESSFUL`,`PENDING`, `FAILED`

    * `:amount` - The amount that was transferred. 

  """
  @spec create_transfer(map()) :: {:ok, Req.Response.t()}
  def create_transfer(params) do
    "/transfers"
    |> ExXendit.post(params)
  end
end
