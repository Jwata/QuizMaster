# Demo data
## User
User.find_or_create_by!(id: 1)

## Questions
Question.find_or_create_by!(id: 1) do |question|
  question.content = "# Which is the highest mountain?\r\n\r\n|Mount Kilimanjaro|Mount Fuji|Denali|\r\n|---|---|---|\r\n|![](https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Mount_Kilimanjaro.jpg/200px-Mount_Kilimanjaro.jpg)|![](https://upload.wikimedia.org/wikipedia/ja/thumb/3/3e/MtFuji_FujiCity.jpg/200px-MtFuji_FujiCity.jpg)|![](https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Wonder_Lake_and_Denali.jpg/200px-Wonder_Lake_and_Denali.jpg)|\r\n"
  question.answer = 'Denali'
end

Question.find_or_create_by!(id: 2) do |question|
  question.content = "# What number should come next in the pattern?\r\n\r\n1, 1, 2, 3, 5, 8, 13"
  question.answer = '21'
end

Question.find_or_create_by!(id: 3) do |question|
  question.content = "# How high is Mount Fuji in meters?\r\n( *answer with meters like \"1234 meters\"* )\r\n\r\n![](https://upload.wikimedia.org/wikipedia/ja/thumb/3/3e/MtFuji_FujiCity.jpg/400px-MtFuji_FujiCity.jpg\" alt=\"MtFuji FujiCity.jpg)"
  question.answer = '3776 meters'
end
