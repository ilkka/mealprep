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

alias MealprepBackend.V1.IngredientClass, as: IngredientClass
alias MealprepBackend.V1.Ingredient, as: Ingredient
alias MealprepBackend.V1.Process, as: Process
alias MealprepBackend.Repo, as: Repo

File.stream!(Path.expand('../../seed_data/igclass.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([t, n | _]) ->
  Repo.insert!(%IngredientClass{name: n,
                                thscode: t})
end)

File.stream!(Path.expand('../../seed_data/process.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([thscode, name | _]) ->
  Repo.insert!(%Process{name: name, thscode: thscode})
end)

File.stream!(Path.expand('../../seed_data/ig.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Stream.take(10)
|> Enum.each(fn([_fid, name, _ft, process, portion, cls, pcls | _]) ->
  cls = Repo.get_by!(IngredientClass, thscode: cls)
  pcls = Repo.get_by!(IngredientClass, thscode: pcls)
  proc = Repo.get_by!(Process, thscode: process)
  {portion, _} = Integer.parse(portion, 10)
  ingredient = Repo.insert!(%Ingredient{name: name,
                                        edible_portion: portion,
                                        process_id: proc.id,
                                        ingredientclass_id: cls.id})
  Repo.update!(%{cls | parent: pcls.id})
end)
