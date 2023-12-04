defmodule ExXendit.Subscription do
  @moduledoc """
  Handles functions at https://developers.xendit.co/api-reference/#plan-create
  """
  alias ExXendit

  @doc """
  Creates a plan

  ## Headers Parameters
    * `:sub_account_id` - The sub-account user-id that you want to make this transaction for.  

    * `:with_split_rule` - Split Rule ID that you would like to apply to this subscriptions plan in order to split and route payments to multiple accounts. 

  ## Body Parameters
    * `:reference_id`* - Reference ID provided by merchant (255 characters)  

    * `:customer_id`* - Xendit-generated customer ID with prefix cust-xxx. Only support customer with type INDIVIDUAL.  

    * `:recurring_action`* - The type of recurring action requested. Supported values - "PAYMENT"  

    * `:currency`* - Currency used for the transaction in ISO4217 format - IDR, PHP, VND, THB 

    * `:amount`* - Amount to be sent to the destination account. Should be a multiple of the minimum increment for the selected channel.

    * `:schedule`* - Data object containing the configurations of how recurring cycles will be scheduled.  

    * `:payment_methods` - Array of payment_method_id that the recurring plan will attempt to make payments with (attempts will be made according to the rank of each object in the array). Only one successful payment will be made  

    * `:immediate_action_type` - the type of action the recurring plan takes upon creation. If the action fails the recurring plan would be inactivated and an inactivated webhook will be sent. Supported values - FULL_AMOUNT - a full charge will be attempted upon recurring plan creation  

    * `:notification_config` - Object containing notification preferences for the recurring plan  

    * `:payment_link_for_failed_attempt` - Default = false. Indicates whether the plan should generate a payment link to be sent to the end customer when the first attempt of the cycle fails. The schedule object of the plan must have a minimum total_retry of 1. The plan's notification_config.recurring_failed determines the channel for which the end customer will receive the notification with the payment link URL. You will also receive the payment link URL in the recurring.cycle.retrying callback.   

    * `:failed_cycle_action` - Default = RESUME. Indicate the behaviour the recurring plan should take when recurring cycles fail. RESUME will ignore failure and continue on with the next recurring cycle. STOP will inactivate the recurring plan and there will be no active recurring cycles. Supported values - RESUME, STOP  

    * `:metadata` - Object of additional information related to the customer. Define the JSON properties and values as required to pass information through the APIs. You can specify up to 50 keys, with key names up to 40 characters long and values up to 500 characters long. This is only for your use and will not be used by Xendit

    * `:description` - Description of recurring plan - you can use this field to list what items are being paid for, or anything else of your choice that describes the function of the recurring plan. This field will be displayed to end users for UI, email or whatsapp.

    * `:items` - Array of objects describing the item/s  

    * `:success_return_url` - URL where the end user is redirected after account linking has been successful. Must be HTTPS or HTTP. Required when payment_method_id is not passed into the request  

    * `:failure_return_url` - URL where the end-customer is redirected if the account linking has failed. Must be HTTPS or HTTP. Required when payment_method_id is not passed into the request  

  """
  @spec create_plan(map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def create_plan(params, headers \\ %{}) do
    url = "recurring/plans"

    if headers != %{} do
      url
      |> ExXendit.post(params, headers)
    else
      url
      |> ExXendit.post(params)
    end
  end
end
