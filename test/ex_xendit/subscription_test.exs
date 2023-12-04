defmodule ExXendit.SubscriptionTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  alias ExXendit.Subscription

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes/subscription")
    :ok
  end

  describe "create_plan/2" do
    test "will return valid result for syd" do
      use_cassette "valid_create_plan_for_syd" do
        plan_id = "9eeddd71-54a7-4fa2-b470-befc5f1far2"
        plan_schedule_id = "9eeddd71-54a7-4fa2-b470-befc5fdfafa2"
        customer_id = "cust-1eecc18d-914a-4f63-8fcf-8b9158d6f1e3"

        params = %{
          reference_id: plan_id,
          customer_id: customer_id,
          recurring_action: "PAYMENT",
          currency: "PHP",
          amount: 1000,
          payment_methods: [],
          schedule: %{
            reference_id: plan_schedule_id,
            interval: "MONTH",
            interval_count: 1,
            total_recurrence: nil,
            anchor_date: "2024-01-01T00:00:00+0800",
            retry_interval: "DAY",
            retry_interval_count: 3,
            total_retry: 2,
            failed_attempt_notifications: [1, 2]
          },
          immediate_action_type: "FULL_AMOUNT",
          notification_config: %{
            recurring_created: ["WHATSAPP", "EMAIL"],
            recurring_succeeded: ["WHATSAPP", "EMAIL"],
            recurring_failed: ["WHATSAPP", "EMAIL"],
            locale: "en"
          },
          failed_cycle_action: "STOP",
          payment_link_for_failed_attempt: true,
          metadata: nil,
          description: "MC subscription",
          items: [
            %{
              type: "DIGITAL_PRODUCT",
              name: "SeeYouDoc MC",
              net_unit_amount: 1000,
              quantity: 1,
              url: nil,
              category: "syd_mc"
            }
          ],
          success_return_url: "https://syd.com/success",
          failure_return_url: "https://syd.com/failure"
        }

        assert {:ok, %{body: body}} = Subscription.create_plan(params)

        assert %{
                 "actions" => [
                   %{
                     "url" => url,
                     "url_type" => "WEB"
                   }
                 ]
               } = body

        assert url =~ "https://linking-dev.xendit.co/"
      end
    end

    test "will return valid result for sub_account" do
      use_cassette "valid_create_plan_for_sub_acount" do
        plan_id = "9eeddd71-54a7-4fa2-b470-befc5f1fa31"
        plan_schedule_id = "9eeddd71-54a7-4fa2-b470-befc5fdfafba"
        customer_id = "cust-70e52cb9-6364-4bb0-a670-190495cbd69d"

        params = %{
          reference_id: plan_id,
          customer_id: customer_id,
          recurring_action: "PAYMENT",
          currency: "PHP",
          amount: 1000,
          payment_methods: [],
          schedule: %{
            reference_id: plan_schedule_id,
            interval: "MONTH",
            interval_count: 1,
            total_recurrence: nil,
            anchor_date: "2024-01-01T00:00:00+0800",
            retry_interval: "DAY",
            retry_interval_count: 3,
            total_retry: 2,
            failed_attempt_notifications: [1, 2]
          },
          immediate_action_type: "FULL_AMOUNT",
          notification_config: %{
            recurring_created: ["WHATSAPP", "EMAIL"],
            recurring_succeeded: ["WHATSAPP", "EMAIL"],
            recurring_failed: ["WHATSAPP", "EMAIL"],
            locale: "en"
          },
          failed_cycle_action: "STOP",
          payment_link_for_failed_attempt: true,
          metadata: nil,
          description: "MC subscription",
          items: [
            %{
              type: "DIGITAL_PRODUCT",
              name: "SeeYouDoc MC",
              net_unit_amount: 1000,
              quantity: 1,
              url: nil,
              category: "syd_mc"
            }
          ],
          success_return_url: "https://syd.com/success",
          failure_return_url: "https://syd.com/failure"
        }

        headers = %{
          sub_account_id: "655d6ef765c63ff7577f0042"
        }

        assert {:ok, %{body: body}} = Subscription.create_plan(params, headers)

        assert %{
                 "actions" => [
                   %{
                     "url" => url,
                     "url_type" => "WEB"
                   }
                 ]
               } = body

        assert url =~ "https://linking-dev.xendit.co/"
      end
    end
  end

  describe "update_plan/3" do
    test "will return valid result for syd" do
      use_cassette "valid_update_plan_for_syd" do
        id = "repl_ff9f901b-a5c3-4f21-99dc-55e2178db0cd"

        params = %{
          amount: 800,
          items: [
            %{
              type: "DIGITAL_PRODUCT",
              name: "SeeYouDoc MC",
              net_unit_amount: 800,
              quantity: 1,
              url: nil,
              category: "syd_mc"
            }
          ]
        }

        assert {:ok, %{body: body}} = Subscription.update_plan(id, params)

        assert %{
                 "actions" => [
                   %{
                     "url" => url,
                     "url_type" => "WEB"
                   }
                 ],
                 "amount" => 800
               } = body

        assert url =~ "https://linking-dev.xendit.co/"
      end
    end

    test "will return valid result for sub account" do
      use_cassette "valid_update_plan_for_sub_account" do
        id = "repl_5a113543-6f98-4442-ad53-85e80494266f"

        params = %{
          amount: 800,
          items: [
            %{
              type: "DIGITAL_PRODUCT",
              name: "SeeYouDoc MC",
              net_unit_amount: 800,
              quantity: 1,
              url: nil,
              category: "syd_mc"
            }
          ]
        }

        headers = %{
          sub_account_id: "655d6ef765c63ff7577f0042"
        }

        assert {:ok, %{body: body}} = Subscription.update_plan(id, params, headers)

        assert %{
                 "actions" => [
                   %{
                     "url" => url,
                     "url_type" => "WEB"
                   }
                 ],
                 "amount" => 800
               } = body

        assert url =~ "https://linking-dev.xendit.co/"
      end
    end
  end

  describe "deactivate_plan/2" do
    test "will return valid result for syd" do
      use_cassette "valid_deactivate_plan_for_syd" do
        id = "repl_ff9f901b-a5c3-4f21-99dc-55e2178db0cd"

        assert {:ok, %{body: body}} = Subscription.deactivate_plan(id)
        assert body["status"] == "INACTIVE"
      end
    end

    test "will return valid result for sub account" do
      use_cassette "valid_deactivate_plan_for_sub_account" do
        id = "repl_5a113543-6f98-4442-ad53-85e80494266f"

        headers = %{
          sub_account_id: "655d6ef765c63ff7577f0042"
        }

        assert {:ok, %{body: body}} = Subscription.deactivate_plan(id, headers)
        assert body["status"] == "INACTIVE"
      end
    end
  end
end
