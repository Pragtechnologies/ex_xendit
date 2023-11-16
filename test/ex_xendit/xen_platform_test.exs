defmodule ExXendit.XenPlatformTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  alias ExXendit.XenPlatform

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes/xen_platform")
    :ok
  end

  describe "create_account/1" do
    test "will return result" do
      use_cassette "valid_create_account" do
        business_email = "a@a.com"

        params = %{
          email: business_email,
          type: "OWNED",
          public_profile: %{
            business_name: "Test business"
          }
        }

        assert {:ok, %{body: %{"email" => email}}} = XenPlatform.create_account(params)
        assert email == business_email
      end
    end
  end

  describe "create_transfer/1" do
    test "will return result" do
      use_cassette "valid_create_transfer" do
        params = %{
          reference: "test_a2",
          amount: 60,
          source_user_id: "63d23daedfa237a41007760b",
          destination_user_id: "655438b31991c5156ae7a348"
        }

        assert {:ok, %{body: body}} = XenPlatform.create_transfer(params)
        assert %{"status" => "SUCCESSFUL"} = body
      end
    end
  end
end
