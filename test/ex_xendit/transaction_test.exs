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
end
