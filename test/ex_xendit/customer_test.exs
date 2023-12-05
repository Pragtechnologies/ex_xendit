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

  describe "get/2" do
    test "will return valid result for syd" do
      use_cassette "valid_get_customer_for_syd" do
        id = "cust-1eecc18d-914a-4f63-8fcf-8b9158d6f1e3"

        assert {:ok, %{body: body}} = Customer.get(id)
        assert body["email"] == "a@a.com"
      end
    end

    test "will return valid result for sub_account" do
      use_cassette "valid_get_customer_for_sub_account" do
        id = "cust-70e52cb9-6364-4bb0-a670-190495cbd69d"

        headers = %{
          sub_account_id: "655d6ef765c63ff7577f0042"
        }

        assert {:ok, %{body: body}} = Customer.get(id, headers)
        assert body["email"] == "a@a.com"
      end
    end
  end

  describe "get_by_reference_id/2" do
    test "will return valid result for syd" do
      use_cassette "valid_get_ref_customer_for_syd" do
        id = "9eeddd71-54a7-4fa2-b470-befc5f1far2"

        assert {:ok, %{body: %{"data" => [body]}}} = Customer.get_by_reference_id(id)
        assert body["email"] == "a@a.com"
      end
    end

    test "will return valid result for sub_account" do
      use_cassette "valid_get_ref_customer_for_sub_account" do
        id = "9eeddd71-54a7-4fa2-b470-befc5f1fa578"

        headers = %{
          sub_account_id: "655d6ef765c63ff7577f0042"
        }

        assert {:ok, %{body: %{"data" => [body]}}} =
                 Customer.get_by_reference_id(id, headers)

        assert body["email"] == "a@a.com"
      end
    end
  end

  describe "update/3" do
    test "will return valid result for syd" do
      use_cassette "valid_update_customer_for_syd" do
        id = "cust-1eecc18d-914a-4f63-8fcf-8b9158d6f1e3"

        params = %{
          email: "b@b.com"
        }

        assert {:ok, %{body: body}} = Customer.update(id, params)
        assert body["email"] == "b@b.com"
      end
    end

    test "will return valid result for sub_account" do
      use_cassette "valid_update_customer_for_sub_account" do
        id = "cust-70e52cb9-6364-4bb0-a670-190495cbd69d"

        params = %{
          email: "b@b.com"
        }

        headers = %{
          sub_account_id: "655d6ef765c63ff7577f0042"
        }

        assert {:ok, %{body: body}} = Customer.update(id, params, headers)
        assert body["email"] == "b@b.com"
      end
    end
  end
end
