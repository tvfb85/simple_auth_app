defmodule SimpleAuth.Post do
  use SimpleAuth.Web, :model

  schema "posts" do
    field :title, :string
    field :body, :string
    belongs_to :user, SimpleAuth.User

    timestamps()
  end

  @required_fields ~w(title)a
  @optional_fields ~w(body)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
