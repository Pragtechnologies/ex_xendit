defmodule ExXendit.CreditCardTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  alias ExXendit.CreditCard

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes/credit_card")
    :ok
  end

  describe "create_charge/1 with capture true for main account" do
    test "will return valid result" do
      use_cassette "valid_create_charge" do
        params = %{
          token_id: "675800ee97e3c90016697cf2",
          authentication_id: "675b9652da69a10016a96628",
          external_id: "8aa91fed-48d1-425d-a9c3-96fa16934167",
          amount: 788.60,
          currency: "PHP",
          capture: true
        }

        assert {:ok, %{body: body}} = CreditCard.create_charge(params)
        assert body["approval_code"] == "831000"
      end
    end
  end

  describe "create_charge/1 with capture false for main account" do
    test "will return valid result" do
      use_cassette "valid_create_charge_capture_false" do
        params = %{
          token_id: "675809b597e3c90016698461",
          authentication_id: "675b9588da69a10016a9661b",
          external_id: "9408f310-6dbc-4bc4-8c7a-b28929a231b8",
          amount: 788.60,
          currency: "PHP",
          capture: false
        }

        assert {:ok, %{body: body}} = CreditCard.create_charge(params)
        assert body["approval_code"] == "831000"
      end
    end
  end

  describe "create_charge/1 with capture false for sub account" do
    test "will return valid result" do
      use_cassette "valid_create_charge_capture_false_sa" do
        params = %{
          token_id: "675bac81da69a10016a9698f",
          authentication_id: "675bac8fda69a10016a96991",
          external_id: "8640be02-dec2-495c-a5b0-b64f736039e7",
          amount: 788.60,
          currency: "PHP",
          capture: false
        }

        headers = %{
          sub_account_id: "656f138e277d4ff66454ecab"
        }

        assert {:ok, %{body: body}} = CreditCard.create_charge(params, headers)
        assert body["approval_code"] == "831000"
      end
    end
  end

  describe "get_charge/1 for main account for multi use" do
    test "will return valid result" do
      use_cassette("valid_get_charge") do
        charge_id = "cc_674c881e5619b600163f598a"

        params = %{
          id_type: "charge"
        }

        assert {:ok, %{body: body}} = CreditCard.get_charge(charge_id, params)
        assert body["approval_code"] == "831000"
      end
    end
  end
end
