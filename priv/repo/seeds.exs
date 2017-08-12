# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mealprep.Repo.insert!(%Mealprep.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Mealprep.{
    Language,
    Repo
}
alias Mealprep.Nutrition.{
    FoodUnit,
    FoodUnitTr
}

# Insert hardcoded languages
[
    %Language{ietfTag: "fi-FI", nativeName: "suomi", englishName: "Finnish"},
    %Language{ietfTag: "sv-FI", nativeName: "svenska", englishName: "Swedish"},
    %Language{ietfTag: "en-US", nativeName: "English", englishName: "English"},
    %Language{ietfTag: "la", nativeName: "tieteellinen", englishName: "Scientific"}
]
|> Enum.each(fn(lang) -> Repo.insert!(lang) end)

# Insert food units, Finnish first
File.stream!(Path.expand("../../seed_data/foodunit_FI.csv", __DIR__))
|> CSV.decode!(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([thscode, description, _]) ->
    lang = Repo.get_by!(Language, ietfTag: "fi-FI")
    unit = Repo.insert!(%FoodUnit{thscode: thscode})
    Repo.insert!(%FoodUnitTr{language_id: lang.id, food_unit_id: unit.id, description: description})
end)
# Then other languages
File.stream!(Path.expand("../../seed_data/foodunit_SV.csv", __DIR__))
|> CSV.decode!(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([thscode, description, _]) ->
    lang = Repo.get_by!(Language, ietfTag: "sv-FI")
    unit = Repo.get_by!(FoodUnit, thscode: thscode)
    Repo.insert!(%FoodUnitTr{language_id: lang.id, food_unit_id: unit.id, description: description})
end)
File.stream!(Path.expand("../../seed_data/foodunit_EN.csv", __DIR__))
|> CSV.decode!(separator: ?;)
|> Stream.drop(1)
|> Enum.each(fn([thscode, description, _]) ->
    lang = Repo.get_by!(Language, ietfTag: "en-US")
    unit = Repo.get_by!(FoodUnit, thscode: thscode)
    Repo.insert!(%FoodUnitTr{language_id: lang.id, food_unit_id: unit.id, description: description})
end)