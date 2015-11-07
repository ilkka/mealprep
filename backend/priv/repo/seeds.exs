# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MealprepBackend.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

File.stream!(Path.expand('../../seed_data/igclass.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([t, n | _]) ->
  MealprepBackend.Repo.insert!(%MealprepBackend.V1.IngredientClass{name: n,
                                                                   thscode: t})
end)
