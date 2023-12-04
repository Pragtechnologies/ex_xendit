defmodule ExXendit.CustomerTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  alias ExXendit.Customer

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes/customer")
    :ok
  end

  describe "create/2" do
    test "will return valid result for syd" do
      use_cassette "valid_create_customer_for_syd" do
        unique_id = "9eeddd71-54a7-4fa2-b470-befc5f1far2"

        params = %{
          reference_id: unique_id,
          type: "INDIVIDUAL",
          individual_detail: %{
            given_names: "John",
            surname: "Doe"
          },
          email: "a@a.com",
          mobile_number: "+639175321158"
        }

        assert {:ok, %{body: body}} = Customer.create(params)
        assert body["email"] == "a@a.com"
      end
    end

    test "will return valid result for sub_account" do
      use_cassette "valid_create_customer" do
        params = %{
          reference_id: "9eeddd71-54a7-4fa2-b470-befc5f1fa578",
          type: "INDIVIDUAL",
          individual_detail: %{
            given_names: "John",
            surname: "Doe"
          },
          email: "a@a.com",
          mobile_number: "+639175321158"
        }

        headers = %{
          sub_account_id: "655d6ef765c63ff7577f0042",
          idempotency_key: "9eeddd71-54a7-4fa2-b470-befc5f1fa5712"
        }

        assert {:ok, %{body: body}} = Customer.create(params, headers)
        assert body["email"] == "a@a.com"
      end
    end
  end
end
