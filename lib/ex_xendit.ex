defmodule ExXendit do
  @moduledoc """
  Handles base http requests
  """

  @doc false
  def get(url, params) do
    url = parse_url(url, params)

    init()
    |> auth()
    |> Req.get(url: url)
  end

  @doc false
  def get(
        url,
        params,
        %{
          sub_account_id: sub_account_id
        }
      ) do
    url = parse_url(url, params)

    init()
    |> auth()
    |> sub_account(sub_account_id)
    |> Req.get(url: url)
  end

  @doc false
  def post(url, params) do
    init()
    |> auth()
    |> Req.post(url: url, json: params)
  end

  @doc false
  def post(
        url,
        params,
        %{
          sub_account_id: sub_account_id,
          fee_rule_id: fee_rule_id
        }
      ) do
    init()
    |> auth()
    |> sub_account(sub_account_id)
    |> fee_rule(fee_rule_id)
    |> Req.post(url: url, json: params)
  end

  @doc false
  def post(
        url,
        params,
        %{
          sub_account_id: sub_account_id
        }
      ) do
    init()
    |> auth()
    |> sub_account(sub_account_id)
    |> Req.post(url: url, json: params)
  end

  defp parse_url(url, nil), do: url
  defp parse_url(url, params), do: url <> "?" <> URI.encode_query(params)

  defp init do
    base_url = Application.get_env(:ex_xendit, :base_url)
    Req.new(base_url: base_url)
  end

  defp auth(req) do
    username = Application.get_env(:ex_xendit, :secret_key)
    key = Base.encode64("#{username}:")

    req
    |> Req.Request.put_headers([
      {"Content-Type", "application/json"},
      {"Authorization", "Basic #{key}"}
    ])
  end

  defp sub_account(req, id) do
    req
    |> Req.Request.put_headers([
      {"for-user-id", id}
    ])
  end

  defp fee_rule(req, id) do
    req
    |> Req.Request.put_headers([
      {"with-fee-rule", id}
    ])
  end

  @typedoc """
  Headers used in Xendit
  """
  @type headers() :: %{
          optional(:sub_account_id) => String.t(),
          optional(:fee_rule_id) => String.t()
        }
end
