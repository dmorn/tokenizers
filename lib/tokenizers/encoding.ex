defmodule Tokenizers.Encoding do
  @type t :: %__MODULE__{resource: binary(), reference: reference()}
  defstruct resource: nil, reference: nil

  alias Tokenizers.Native
  alias Tokenizers.Shared

  @doc """
  Get the tokens from an encoding.
  """
  @spec get_tokens(Encoding.t()) :: [binary()]
  def get_tokens(encoding), do: encoding |> Native.get_tokens() |> Shared.unwrap()

  @doc """
  Get the ids from an encoding.
  """
  @spec get_ids(Encoding.t()) :: [integer()]
  def get_ids(encoding), do: encoding |> Native.get_ids() |> Shared.unwrap()

  @doc """
  Get the attention_mask from an encoding.
  """
  @spec get_attention_mask(Encoding.t()) :: [integer()]
  def get_attention_mask(encoding), do: encoding |> Native.get_attention_mask() |> Shared.unwrap()

  @doc """
  Truncate the encoding to the given length.

  ## Options
    * `direction` - The truncation direction. Can be `:right` or `:left`. Default: `:right`.
    * `stride` - The length of previous content to be included in each overflowing piece. Default: `0`.
  """
  @spec truncate(encoding :: Encoding.t(), length :: integer(), opts :: Keyword.t()) ::
          Encoding.t()
  def truncate(encoding, max_len, opts \\ []) do
    opts = Keyword.validate!(opts, direction: :right, stride: 0)
    encoding |> Native.truncate(max_len, opts[:stride], "#{opts[:direction]}") |> Shared.unwrap()
  end

  @doc """
  Pad the encoding to the given length.

  ## Options
    * `direction` - The padding direction. Can be `:right` or `:left`. Default: `:right`.
    * `pad_id` - The id corresponding to the padding token. Default: `0`.
    * `pad_token` - The padding token to use. Default: `"[PAD]"`.
    * `pad_type_id` - The type ID corresponding to the padding token. Default: `0`.
  """
  @spec pad(encoding :: Encoding.t(), length :: pos_integer(), opts :: Keyword.t()) ::
          Encoding.t()
  def pad(encoding, length, opts \\ []) do
    opts =
      Keyword.validate!(opts, direction: :right, pad_id: 0, pad_type_id: 0, pad_token: "[PAD]")

    encoding
    |> Native.pad(
      length,
      opts[:pad_id],
      opts[:pad_type_id],
      opts[:pad_token],
      "#{opts[:direction]}"
    )
    |> Shared.unwrap()
  end

  @doc """
  Returns the number of tokens in an `Encoding.t()`.
  """
  @spec n_tokens(encoding :: Encoding.t()) :: non_neg_integer()
  def n_tokens(encoding), do: encoding |> Native.n_tokens() |> Shared.unwrap()
end
  end
end
