require "http"
require "emoji_flag"
require "tty-font"
require "pastel"
require "tty-table"
require "tty-pie"

system "clear"



#Doesn't work, private method. Put in Class?
  # def flag
  #   if nationality == "Austrian"
  #     nationality = "Austrian #{at_flag}"
  #   elsif nationality == "Italian"
  #     nationality = "Italian #{it_flag}"
  #   elsif nationality == "German"
  #     nationality = "German #{de_flag}"
  #   elsif nationality == "French"
  #     nationality = "French #{fr_flag}"
  #   elsif nationality == "Dutch"
  #     @nationality = "Dutch #{nl_flag}"
  #   elsif nationality == "Australian"
  #     nationality = "Australian #{au_flag}"
  #   elsif nationality == "American"
  #     nationality = "American #{us_flag}"
  #   elsif nationality == "British"
  #     nationality = "British #{uk_flag}"
  #   elsif nationality == "Swiss"
  #     nationality = "Swiss #{sw_flag}"
  #   elsif nationality == "Mexican"
  #     nationality = "Mexican #{mex_flag}"
  #   elsif nationality == "Chinese"
  #     nationality = "Chinese #{chn_flag}"
  #   elsif nationality == "Japanese"
  #     nationality = "Japanese #{ja_flag}"
  #   elsif nationality == "Danish"
  #     nationality = "Danish #{da_flag}"
  #   elsif nationality == "Finnish"
  #     nationality = "Finnish #{fi_flag}"
  #   elsif nationality == "Canadian"
  #     nationality = "Canadian #{can_flag}"
  #   elsif nationality == "Monegasque"
  #     nationality = "Monegasque #{mon_flag}"
  #   elsif nationality == "Thai"
  #     nationality = "Thai #{th_flag}"
  #   elsif nationality == "Spanish"
  #     nationality = "Spanish #{es_flag}"
  #   end
  # end


us_flag = EmojiFlag.new("en_US")
au_flag = EmojiFlag.new("en_AU")
de_flag = EmojiFlag.new("de")
nl_flag = EmojiFlag.new("nl")
uk_flag = EmojiFlag.new("en")
it_flag = EmojiFlag.new("it")
fr_flag = EmojiFlag.new("fr")
at_flag = EmojiFlag.new("de_AT")
sw_flag = EmojiFlag.new("de_CH")
mex_flag = EmojiFlag.new("es_MX")
es_flag = EmojiFlag.new("es")
chn_flag = EmojiFlag.new("zh_CN")
ja_flag = EmojiFlag.new("ja")
da_flag = EmojiFlag.new("da")
fi_flag = EmojiFlag.new("fi")
can_flag = EmojiFlag.new("fr_CA")
mon_flag = EmojiFlag.new("fr_MC")
th_flag = EmojiFlag.new("th")

pastel = Pastel.new
font = TTY::Font.new(:straight)

puts pastel.white.bold.on_black("|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|")
puts pastel.white.bold.on_black(font.write("Formula 1 - 2022 Season"))
puts pastel.white.bold.on_black("|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|")

puts "Welcome to the 2022 Formula 1 Data App. With the conclusion of the 2022 season, we have some data available for you."
puts ""
puts "Enter [1] for a list of all the Grand Prix's Circuits in the 2022 season."
puts "Enter [2] for a complete list of the final standings for all drivers."
puts "Enter [3] for a complete list of the constructor's final standings."
puts "Enter [4] for a POINTLESS, NON-FUNCTIONING PIE CHART (JUST BECAUSE WHY NOT?) of the constructor's final standings."
puts "Enter [X] to exit."

while true
input = gets.chomp.upcase
  if input == "X"
    puts pastel.italic.green("THANKS FOR RACING THROUGH MY APP!")
    break
  end


if input == "1"
  response = HTTP.get("https://ergast.com/api/f1/2022/circuits.json")
  circuits = response.parse(:json)
  index = 0
  22.times do
    track = circuits["MRData"]["CircuitTable"]["Circuits"][index]["circuitName"]
    city = circuits["MRData"]["CircuitTable"]["Circuits"][index]["Location"]["locality"]
    country = circuits["MRData"]["CircuitTable"]["Circuits"][index]["Location"]["country"]
    puts "(#{index + 1})" + pastel.green.bold("#{track}") + " located in #{city}, #{country}."
    index = index + 1
  end

  puts pastel.magenta.bold("--------------------------------------------------------------------------------------------------")
  puts "Type and enter in the respective number to select the race of choice, and push enter to get a synopsis of the race results."
  puts pastel.magenta.bold("--------------------------------------------------------------------------------------------------")

  race = gets.chomp

  response = HTTP.get("https://ergast.com/api/f1/2022/#{race}/results.json")
  results = response.parse(:json)
  index = 0
  puts "PODIUM"
  3.times do
    position = results["MRData"]["RaceTable"]["Races"][0]["Results"][index]["position"]
    #HOW TO DRY UP?
    if position == "1"
      position = "1st"
    elsif
      position == "2"
      position = "2nd"
    elsif
      position == "3"
      position = "3rd"
    end
    family_name = results["MRData"]["RaceTable"]["Races"][0]["Results"][index]["Driver"]["familyName"]
    given_name = results["MRData"]["RaceTable"]["Races"][0]["Results"][index]["Driver"]["givenName"]
    nationality = results["MRData"]["RaceTable"]["Races"][0]["Results"][index]["Driver"]["nationality"]
    team = results["MRData"]["RaceTable"]["Races"][0]["Results"][index]["Constructor"]["name"]
    puts "#{position} ==> #{pastel.underline("Driver:")} #{family_name}, #{given_name}. #{pastel.underline("Nationality:")} #{nationality} #{pastel.underline("Team:")} #{team}"
    index += 1
  end
end

if input == "2"
  response = HTTP.get("https://ergast.com/api/f1/2022/driverStandings.json")
  standings = response.parse(:json)
  index = 0
  puts pastel.blue.bold("FINAL CHAMPIONSHIP STANDINGS")
  22.times do
    family_name = standings["MRData"]["StandingsTable"]["StandingsLists"][0]["DriverStandings"][index]["Driver"]["familyName"]
    given_name = standings["MRData"]["StandingsTable"]["StandingsLists"][0]["DriverStandings"][index]["Driver"]["givenName"]
    nationality = standings["MRData"]["StandingsTable"]["StandingsLists"][0]["DriverStandings"][index]["Driver"]["nationality"]
    #HOW TO DRY UP?
    if nationality == "Austrian"
      nationality = "Austrian #{at_flag}"
    elsif nationality == "Italian"
      nationality = "Italian #{it_flag}"
    elsif nationality == "German"
      nationality = "German #{de_flag}"
    elsif nationality == "French"
      nationality = "French #{fr_flag}"
    elsif nationality == "Dutch"
      nationality = "Dutch #{nl_flag}"
    elsif nationality == "Australian"
      nationality = "Australian #{au_flag}"
    elsif nationality == "American"
      nationality = "American #{us_flag}"
    elsif nationality == "British"
      nationality = "British #{uk_flag}"
    elsif nationality == "Swiss"
      nationality = "Swiss #{sw_flag}"
    elsif nationality == "Mexican"
      nationality = "Mexican #{mex_flag}"
    elsif nationality == "Chinese"
      nationality = "Chinese #{chn_flag}"
    elsif nationality == "Japanese"
      nationality = "Japanese #{ja_flag}"
    elsif nationality == "Danish"
      nationality = "Danish #{da_flag}"
    elsif nationality == "Finnish"
      nationality = "Finnish #{fi_flag}"
    elsif nationality == "Canadian"
      nationality = "Canadian #{can_flag}"
    elsif nationality == "Monegasque"
      nationality = "Monegasque #{mon_flag}"
    elsif nationality == "Thai"
      nationality = "Thai #{th_flag}"
    elsif nationality == "Spanish"
      nationality = "Spanish #{es_flag}"
    end
    position = standings["MRData"]["StandingsTable"]["StandingsLists"][0]["DriverStandings"][index]["position"]
    total_points = standings["MRData"]["StandingsTable"]["StandingsLists"][0]["DriverStandings"][index]["points"]

    puts "Driver: #{family_name}, #{given_name}. Nationality: #{nationality}  ||  Total Points: #{total_points}. Overall Position: #{position}."
    index += 1
  end
end

if input == "3"
  response = HTTP.get("https://ergast.com/api/f1/2022/constructorStandings.json")
  standings = response.parse(:json)
  index = 0
  
  puts pastel.red.bold("FINAL CONSTRUCTOR STANDINGS")
  table = TTY::Table.new(header:[pastel.red.bold("Team"),pastel.red.bold("Nationality"), pastel.red.bold("Points"), pastel.red.bold("Position")])
  10.times do
    constructor = standings["MRData"]["StandingsTable"]["StandingsLists"][0]["ConstructorStandings"][index]["Constructor"]["name"]
    nationality = standings["MRData"]["StandingsTable"]["StandingsLists"][0]["ConstructorStandings"][index]["Constructor"]["nationality"]
    #HOW TO DRY UP?
    if nationality == "Austrian"
      nationality = "Austrian #{at_flag}"
    elsif nationality == "Italian"
      nationality = "Italian #{it_flag}"
    elsif nationality == "German"
      nationality = "German #{de_flag}"
    elsif nationality == "French"
      nationality = "French #{fr_flag}"
    elsif nationality == "Dutch"
      nationality = "Dutch #{nl_flag}"
    elsif nationality == "Australian"
      nationality = "Australian #{au_flag}"
    elsif nationality == "American"
      nationality = "American #{us_flag}"
    elsif nationality == "British"
      nationality = "British #{uk_flag}"
    elsif nationality == "Swiss"
      nationality = "Swiss #{sw_flag}"
    elsif nationality == "Mexican"
      nationality = "Mexican #{mex_flag}"
    elsif nationality == "Chinese"
      nationality = "Chinese #{chn_flag}"
    elsif nationality == "Japanese"
      nationality = "Japanese #{ja_flag}"
    elsif nationality == "Danish"
      nationality = "Danish #{da_flag}"
    elsif nationality == "Finnish"
      nationality = "Finnish #{fi_flag}"
    elsif nationality == "Canadian"
      nationality = "Canadian #{can_flag}"
    elsif nationality == "Monegasque"
      nationality = "Monegasque #{mon_flag}"
    elsif nationality == "Thai"
      nationality = "Thai #{th_flag}"
    elsif nationality == "Spanish"
      nationality = "Spanish #{es_flag}"
    end
    position = standings["MRData"]["StandingsTable"]["StandingsLists"][0]["ConstructorStandings"][index]["position"]
    total_points = standings["MRData"]["StandingsTable"]["StandingsLists"][0]["ConstructorStandings"][index]["points"]

    table << ["#{constructor}", "#{nationality}", "#{total_points}", "#{position}"]

    ### REGULAR LINE OUTPUT
    # puts "Team: #{constructor}. Nationality: #{nationality}  ||  Points: #{total_points}. Overall Position: #{position}."

    index += 1
  end
  puts table.render(:ascii, alignments: [:center, :center, :center, :center,], width: 70, resize: true)
 
end

# if input == "4"
#     response = HTTP.get("https://ergast.com/api/f1/2022/constructorStandings.json")
#     standings = response.parse(:json)
    
#     puts pastel.red.bold("STUPID PIE CHART")
    
#     data = [
#       {name: "Red Bull", value: 759, color: :blue, fill: "+"},
#       {name: "Ferrari", value: 554, color: :red, fill: "-"},
#       {name: "Mercedes", value: 515, color: :cyan, fill: "*"},
#       {name: "Alpine", value: 173, color: :magenta, fill: "x"},
#       {name: "McLaren", value: 159, color: :yellow, fill: "#"},
#       {name: "Alfa Romeo", value: 55, color: :bright_green, fill: "@"},
#       {name: "Aston Martin", value: 55, color: :greeb, fill: "&"},
#       {name: "Haas", value: 37, color: :bright_red, fill: "<"},
#       {name: "AlphaTauri", value: 35, color: :bright_blue, fill: ";"},
#       {name: "Williams", value: 8, color: :bright_cyan, fill: "o"}
#     ]
    
#     pie_chart = TTY::Pie.new(data: data, radius: 5)
#     puts pie_chart
#   end
end