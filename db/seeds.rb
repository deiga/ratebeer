# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
b1 = Brewery.find_or_create_by! name:"Koff", year:1897
b2 = Brewery.find_or_create_by! name:"Malmgard", year:2001
b3 = Brewery.find_or_create_by! name:"Weihenstephaner", year:1042

s1 = Style.create name:'European Pale Ale', description: 'The English Pale Ale can be traced back to the city of Burton-upon-Trent, a city with an abundance of rich hard water. This hard water helps with the clarity as well as enhancing the hop bitterness. This ale can be from golden to reddish amber in color with generally a good head retention. A mix of fruity, hoppy, earthy, buttery and malty aromas and flavors can be found. Typically all ingredients are English.'
s2 = Style.create name:'European Pale Lager', description: 'Similar to the Munich Helles story, many European countries reacted to the popularity of early pale lagers by brewing their own. Hop flavor is significant and of noble varieties, bitterness is moderate, and both are backed by a solid malt body and sweetish notes from an all-malt base.'
s3 = Style.create name:'Baltic Porter', description: "Porters of the late 1700's were quite strong compared to todays standards, easily surpassing 7% alcohol by volume. Some brewers made a stronger, more robust version, to be shipped across the North Sea, dubbed a Baltic Porter. In general, the styles dark brown color covered up cloudiness and the smoky/roasted brown malts and bitter tastes masked brewing imperfections. The addition of stale ale also lent a pleasant acidic flavor to the style, which made it quite popular. These issues were quite important given that most breweries were getting away from pub brewing and opening up breweries that could ship beer across the world."
s4 = Style.create name:'Hefeweizen', description: %{A south German style of wheat beer (weissbier) made with a typical ratio of 50:50, or even higher, wheat. A yeast that produces a unique phenolic flavors of banana and cloves with an often dry and tart edge, some spiciness, bubblegum or notes of apples. Little hop bitterness, and a moderate level of alcohol. The "Hefe" prefix means "with yeast", hence the beers unfiltered and cloudy appearance. Poured into a traditional Weizen glass, the Hefeweizen can be one sexy looking beer.

Often served with a lemon wedge (popularized by Americans), to either cut the wheat or yeast edge, which many either find to be a flavorful snap ... or an insult and something that damages the beer's taste and head retention.}

b1.beers.create name:"Iso 3", style:s2
b1.beers.create name:"Karhu", style:s2
b2.beers.create name:"Huvila Pale Ale", style:s1
b2.beers.create name:"X Porter", style:s3
b3.beers.create name:"Hefezeizen", style:s4
b3.beers.create name:"Helles", style:s2
