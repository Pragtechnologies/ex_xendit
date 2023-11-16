defmodule ExXendit.TransactionTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  alias ExXendit.Transaction

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes")
    :ok
  end

  describe "list/1 for main account" do
    test "will return result" do
      use_cassette "main_transactions" do
        params = %{currency: "PHP"}

        assert {:ok, %{body: body}} = Transaction.list(params)
        assert %{"data" => [data | _]} = body
        assert %{"business_id" => "6163f373dac5503a0705b783"} = data
      end
    end
  end

  describe "list/2 for sub-account" do
    test "will return result" do
      use_cassette "sa_transactions" do
        sub_account_id = "655438ce1991c5156ae7a4e5"
        params = %{currency: "PHP"}

        assert {:ok, %{body: body}} = Transaction.list(params, sub_account_id)
        assert %{"data" => [data | _]} = body
        assert %{"business_id" => "655438ce1991c5156ae7a4e5"} = data
      end
    end
  end

  describe "get/1 for main account" do
    test "will return result" do
      use_cassette "get_main_transaction" do
        assert {:ok, %{body: body}} = Transaction.get("txn_cda37af7-be6f-4424-b7d2-71eee10c3993")
        assert %{"business_id" => "6163f373dac5503a0705b783"} = body
      end
    end
  end

  describe "get/2 for sub account" do
    test "will return result" do
      use_cassette "get_sa_transaction" do
        sub_account_id = "655438ce1991c5156ae7a4e5"

        assert {:ok, %{body: body}} =
                 Transaction.get("txn_75e5e006-8301-48ad-b879-48da5fa368f7", sub_account_id)

        assert %{"business_id" => "655438ce1991c5156ae7a4e5"} = body
      end
    end
  end
end
