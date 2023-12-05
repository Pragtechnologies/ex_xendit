defmodule ExXendit.Customer do
  @moduledoc """
  Handles functions at https://developers.xendit.co/api-reference/#customer-object
  """
  alias ExXendit

  @doc """
  Creates a customer.

  ## Headers Parameters
    * `:idempotency_key`* - A unique key to prevent processing duplicate requests. Can be your reference_id or any GUID. Must be unique across development & production environments.  

    * `:sub_account_id` - The sub-account user-id that you want to make this transaction for.  

    * `:api_version` - API version in date semantic (e.g. 2020-10-31). Attach this parameter when calling a specific API version. List of API versions can be found [here](https://developers.xendit.co/api-reference/#changelog) 

  ## Body Parameters
    * `:reference_id`* - Reference ID provided by merchant (255 characters)  

    * `:type`* - Type of customer. Supported values: `INDIVIDUAL`, `BUSINESS`  

    * `:individual_detail`* - JSON object containing details of the individual. Required if type is `INDIVIDUAL`  

    * `:business_detail`* - JSON object containing details of the business. Required if type is `BUSINESS`  

    * `:mobile_number` - Mobile number of customer in E.164 format  

    * `:phone_number` - Additional contact number of customer in E.164 format. May be a landline  

    * `:hashed_phone_number` - Hashed phone number  

    * `:email` - E-mail address of customer  

    * `:addresses` - Array of address JSON objects containing the customer's various address information. 

    * `:identity_accounts` - Array of JSON objects with information relating to financial, social media or other accounts associated with the customer. This array can store details for KYC purposes and can support storing of account details for execution of payments within the Xendit API ecosystem. 

    * `:kyc_documents` - Array of JSON objects with documents collected for KYC of this customer. 

    * `:description` - Merchant-provided description for the customer.

    * `:date_of_registration` - Date of which the account that the shopper had to create/sign up on the merchant’s website

    * `:domicile_of_registration` - Country within which the account that the shopper had to create/sign up on the merchant’s website resides (e.g. accounts created on Shopee SG have SG as the value for this field. ISO 3166-2 Country Code

    * `:metadata` - Object of additional information related to the customer. Define the JSON properties and values as required to pass information through the APIs. You can specify up to 50 keys, with key names up to 40 characters long and values up to 500 characters long. This is only for your use and will not be used by Xendit

  """
  @spec create(map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def create(params, headers \\ %{}) do
    if headers != %{} do
      "customers"
      |> ExXendit.post(params, headers)
    else
      "customers"
      |> ExXendit.post(params)
    end
  end

  @doc """
  Get a customer.

  ## Headers Parameters
    * `:sub_account_id` - The sub-account user-id that you want to make this transaction for.  

    * `:api_version` - API version in date semantic (e.g. 2020-10-31). Attach this parameter when calling a specific API version. List of API versions can be found [here](https://developers.xendit.co/api-reference/#changelog) 

  ## Request Parameters
    * `:id`* - Xendit generated customer id  

  """
  @spec get(String.t(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def get(id, headers \\ %{}) do
    if headers != %{} do
      "customers/#{id}"
      |> ExXendit.get(%{}, headers)
    else
      "customers/#{id}"
      |> ExXendit.get(%{})
    end
  end

  @doc """
  Get a customer by reference_id.

  ## Headers Parameters
    * `:sub_account_id` - The sub-account user-id that you want to make this transaction for.  

    * `:api_version` - API version in date semantic (e.g. 2020-10-31). Attach this parameter when calling a specific API version. List of API versions can be found [here](https://developers.xendit.co/api-reference/#changelog) 

  ## Request Parameters
    * `:reference_id`* - Your identifier for the customer  

  """
  @spec get_by_reference_id(String.t(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def get_by_reference_id(reference_id, headers \\ %{}) do
    if headers != %{} do
      "customers?reference_id=#{reference_id}"
      |> ExXendit.get(%{}, headers)
    else
      "customers?reference_id=#{reference_id}"
      |> ExXendit.get(%{})
    end
  end

  @doc """
  Update a customer

  ## Headers Parameters
    * `:sub_account_id` - The sub-account user-id that you want to make this transaction for.  

    * `:api_version` - API version in date semantic (e.g. 2020-10-31). Attach this parameter when calling a specific API version. List of API versions can be found [here](https://developers.xendit.co/api-reference/#changelog) 

  ## Body Parameters
    * `:individual_detail`* - JSON object containing details of the individual. Required if type is `INDIVIDUAL`  

    * `:business_detail`* - JSON object containing details of the business. Required if type is `BUSINESS`  

    * `:mobile_number` - Mobile number of customer in E.164 format  

    * `:phone_number` - Additional contact number of customer in E.164 format. May be a landline  

    * `:email` - E-mail address of customer  

    * `:addresses` - Array of address JSON objects containing the customer's various address information. 

    * `:identity_accounts` - Array of JSON objects with information relating to financial, social media or other accounts associated with the customer. This array can store details for KYC purposes and can support storing of account details for execution of payments within the Xendit API ecosystem. 

    * `:kyc_documents` - Array of JSON objects with documents collected for KYC of this customer. 

    * `:description` - Merchant-provided description for the customer.

    * `:date_of_registration` - Date of which the account that the shopper had to create/sign up on the merchant’s website

    * `:domicile_of_registration` - Country within which the account that the shopper had to create/sign up on the merchant’s website resides (e.g. accounts created on Shopee SG have SG as the value for this field. ISO 3166-2 Country Code

    * `:metadata` - Object of additional information related to the customer. Define the JSON properties and values as required to pass information through the APIs. You can specify up to 50 keys, with key names up to 40 characters long and values up to 500 characters long. This is only for your use and will not be used by Xendit

  """
  @spec update(String.t(), map(), ExXendit.headers()) :: {:ok, Req.Response.t()}
  def update(id, params, headers \\ %{}) do
    if headers != %{} do
      "customers/#{id}"
      |> ExXendit.patch(params, headers)
    else
      "customers/#{id}"
      |> ExXendit.patch(params)
    end
  end
end
