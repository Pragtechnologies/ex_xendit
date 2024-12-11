defmodule ExXendit.CreditCardTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  alias ExXendit.CreditCard

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes/credit_card")
    :ok
  end

  describe "create_charge/1 for main account for multi use" do
    test "will return valid result" do
      # use_cassette "valid_create_token" do
      params = %{
        amount: nil,
        card_data: %{
          account_number: "4456530000001096",
          exp_month: "12",
          exp_year: "2029",
          card_holder_first_name: "John",
          card_holder_last_name: "Doe",
          card_holder_email: "johndoe@gmai.com",
          card_holder_phone_number: "628212223242526"
        },
        external_id: "test12345",
        card_cvn: "123",
        is_multiple_use: true,
        should_authenticate: true,
        currency: "PHP",
        mid_label: nil
      }

      assert {:ok, %{body: body}} = CreditCard.create_charge(params) |> dbg()
      # assert %{"business_id" => "6163f373dac5503a0705b783"} = body
      # end
    end
  end
end
