defmodule ExXendit.EWalletTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  alias ExXendit.EWallet

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes/e_wallet")
    :ok
  end

  describe "create_charge/2 for main account" do
    test "will return valid result" do
      use_cassette "valid_create_charge" do
        params = %{
          reference_id: "test12345",
          currency: "PHP",
          amount: 500.50,
          checkout_method: "ONE_TIME_PAYMENT",
          channel_code: "PH_GCASH",
          channel_properties: %{
            success_redirect_url: "https://www.google.com?success",
            failure_redirect_url: "https://www.google.com?fail"
          }
        }

        assert {:ok, %{body: body}} = EWallet.create_charge(params)
        assert %{"business_id" => "6163f373dac5503a0705b783"} = body
      end
    end
  end

  describe "create_charge/2 for main account and fee rule" do
    test "will return valid result" do
      use_cassette "valid_sa_fr_create_charge" do
        params = %{
          reference_id: "test7899",
          currency: "PHP",
          amount: 320.50,
          checkout_method: "ONE_TIME_PAYMENT",
          channel_code: "PH_GCASH",
          channel_properties: %{
            success_redirect_url: "https://www.google.com?success",
            failure_redirect_url: "https://www.google.com?fail"
          }
        }

        headers = %{
          with_split_rule: "xpfeeru_7e63a434-4257-4c20-99e9-4df1b3885583"
        }

        assert {:ok, %{body: body}} = EWallet.create_charge(params, headers)
        assert %{"business_id" => "655438ce1991c5156ae7a4e5"} = body
      end
    end
  end

  describe "create_charge/2 for sub account" do
    test "will return valid result" do
      use_cassette "valid_sa_create_charge" do
        params = %{
          reference_id: "test789",
          currency: "PHP",
          amount: 320.50,
          checkout_method: "ONE_TIME_PAYMENT",
          channel_code: "PH_GCASH",
          channel_properties: %{
            success_redirect_url: "https://www.google.com?success",
            failure_redirect_url: "https://www.google.com?fail"
          }
        }

        headers = %{
          sub_account_id: "655438ce1991c5156ae7a4e5"
        }

        assert {:ok, %{body: body}} = EWallet.create_charge(params, headers)
        assert %{"business_id" => "655438ce1991c5156ae7a4e5"} = body
      end
    end
  end

  describe "create_charge/2 for sub account and fee rule" do
    test "will return valid result" do
      use_cassette "valid_sa_fr_create_charge" do
        params = %{
          reference_id: "test7899",
          currency: "PHP",
          amount: 320.50,
          checkout_method: "ONE_TIME_PAYMENT",
          channel_code: "PH_GCASH",
          channel_properties: %{
            success_redirect_url: "https://www.google.com?success",
            failure_redirect_url: "https://www.google.com?fail"
          }
        }

        headers = %{
          sub_account_id: "655438ce1991c5156ae7a4e5",
          with_split_rule: "xpfeeru_7e63a434-4257-4c20-99e9-4df1b3885583"
        }

        assert {:ok, %{body: body}} = EWallet.create_charge(params, headers)
        assert %{"business_id" => "655438ce1991c5156ae7a4e5"} = body
      end
    end
  end
end
