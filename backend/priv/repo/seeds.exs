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

alias MealprepBackend.V1.IngredientClass
alias MealprepBackend.V1.Ingredient
alias MealprepBackend.V1.Process
alias MealprepBackend.V1.ComponentClass
alias MealprepBackend.V1.Unit
alias MealprepBackend.V1.Component
alias MealprepBackend.V1.ComponentValue
alias MealprepBackend.Repo

File.stream!(Path.expand('../../seed_data/igclass_FI.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([t, n | _]) ->
  Repo.insert!(%IngredientClass{name: n,
                                thscode: t})
end)

File.stream!(Path.expand('../../seed_data/process_FI.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([thscode, name | _]) ->
  Repo.insert!(%Process{name: name, thscode: thscode})
end)

File.stream!(Path.expand('../../seed_data/food.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([fid, name, _ft, process, portion, cls, pcls | _]) ->
  cls = Repo.get_by!(IngredientClass, thscode: cls)
  pcls = Repo.get_by!(IngredientClass, thscode: pcls)
  proc = Repo.get_by!(Process, thscode: process)
  {portion, _} = Integer.parse(portion, 10)
  {fid, _} = Integer.parse(fid, 10)
  ingredient = Repo.insert!(%Ingredient{name: name,
                                        fineli_foodid: fid,
                                        edible_portion: portion,
                                        process_id: proc.id,
                                        ingredientclass_id: cls.id})
  Repo.update!(%{cls | parent_id: pcls.id})
end)

File.stream!(Path.expand('../../seed_data/cmpclass_FI.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([thscode, name | _]) ->
  Repo.insert!(%ComponentClass{name: name, thscode: thscode})
end)

File.stream!(Path.expand('../../seed_data/compunit_FI.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([thscode, name | _]) ->
  Repo.insert!(%Unit{name: name, thscode: thscode})
end)

File.stream!(Path.expand('../../seed_data/component.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([eufdname, unitname, clsname, pclsname]) ->
  unit = Repo.get_by!(Unit, thscode: unitname)
  cls = Repo.get_by!(ComponentClass, thscode: clsname)
  pcls = Repo.get_by!(ComponentClass, thscode: pclsname)
  Repo.insert!(%Component{name: eufdname,
                          unit_id: unit.id,
                          componentclass_id: cls.id})
  Repo.update!(%{cls | parent_id: pcls.id})
end)

File.stream!(Path.expand('../../seed_data/component_value.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([fid, eufdname, value | _]) ->
  ingredient = Repo.get_by!(Ingredient, fineli_foodid: fid)
  component = Repo.get_by!(Component, name: eufdname)
  {value, _} = Float.parse(String.replace(value, ",", "."))
  Repo.insert!(%ComponentValue{value: value,
                               ingredient_id: ingredient.id,
                               component_id: component.id})
end)

File.stream!(Path.expand('../../seed_data/eufdname_FI.csv', __DIR__))
|> CSV.decode(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([thscode, name | _]) ->
  comp = Repo.get_by(Component, name: thscode)
  if comp != nil do
    Repo.update!(%{comp | name: name})
  end
end)
