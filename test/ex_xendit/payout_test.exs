defmodule ExXendit.PayoutTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  alias ExXendit.Payout

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes/payout")
    :ok
  end

  describe "create/2" do
    test "will return valid result" do
      use_cassette "valid_create_payout" do
        params = %{
          reference_id: "9eeddd71-54a7-4fa2-b470-befc5f1fa578",
          channel_code: "PH_GCASH",
          channel_properties: %{
            account_holder_name: "Noel Del Castillo",
            account_number: "09175341122"
          },
          currency: "PHP",
          amount: 150.00,
          description: "test payout",
          receipt_notification: %{
            email_to: ["noel@pragtechnologies.com"]
          }
        }

        headers = %{
          sub_account_id: "655d6ef765c63ff7577f0042",
          idempotency_key: "9eeddd71-54a7-4fa2-b470-befc5f1fa578"
        }

        assert {:ok, %{body: body}} = Payout.create(params, headers)
        assert body["business_id"] == "655d6ef765c63ff7577f0042"
      end
    end
  end
end
