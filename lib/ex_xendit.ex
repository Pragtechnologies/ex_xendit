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

  def get(url, params, headers) do
    url = parse_url(url, params)

    init()
    |> auth()
    |> parse_headers(headers)
    |> Req.get(url: url)
  end

  @doc false
  def post(url, params) do
    init()
    |> auth()
    |> Req.post(url: url, json: params)
  end

  @doc false
  def post(url, params, headers) do
    init()
    |> auth()
    |> parse_headers(headers)
    |> Req.post(url: url, json: params)
  end

  @doc false
  def patch(url, params) do
    init()
    |> auth()
    |> Req.patch(url: url, json: params)
  end

  @doc false
  def patch(url, params, headers) do
    init()
    |> auth()
    |> parse_headers(headers)
    |> Req.patch(url: url, json: params)
  end

  defp parse_headers(request, headers) do
    request
    |> sub_account(headers)
    |> fee_rule(headers)
    |> idempotency_key(headers)
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

  defp sub_account(req, %{sub_account_id: id}) do
    req
    |> Req.Request.put_headers([
      {"for-user-id", id}
    ])
  end

  defp sub_account(req, _), do: req

  defp fee_rule(req, %{with_split_rule: id}) do
    req
    |> Req.Request.put_headers([
      {"with-split-rule", id}
    ])
  end

  defp fee_rule(req, _), do: req

  defp idempotency_key(req, %{idempotency_key: id}) do
    req
    |> Req.Request.put_headers([
      {"Idempotency-key", id}
    ])
  end

  defp idempotency_key(req, _), do: req

  @typedoc """
  Headers used in Xendit

  ## Parameters
    * `:sub_account_id` - The sub-account user-id  

    * `:with_split_rule` - Split Rule ID that you would like to apply to this eWallet charge  

    * `:idempotency_key` - 	A unique key to prevent processing duplicate requests. Can be your reference_id or any GUID. Must be unique across development & production environments.  
  """
  @type headers() :: %{
          optional(:sub_account_id) => String.t(),
          optional(:with_split_rule) => String.t(),
          optional(:idempotency_key) => String.t()
        }
end
