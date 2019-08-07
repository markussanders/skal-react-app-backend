require 'rest-client'
require 'json'


def initial_parse(url, desc)
  response = RestClient.get(url)
  json = JSON.parse(response)
  json["drinks"].each { |drink| 
    new_drink = Drink.find_or_create_by(name: drink["strDrink"])
    new_drink.update(tools: [drink["strGlass"]])
    new_drink.update(directions: drink["strInstructions"])
    new_drink.update(image_url: drink["strDrinkThumb"])
    ingredients = get_ingredients(drink)
    true_ingredients = ingredients.filter{|ingredient| ingredient.length > 0}
    new_drink.update(ingredients: true_ingredients)
    new_drink.update(description: desc, favorited_count: get_random_num)
  }
end

def get_ingredients(drink)
  ingredient = ''
  output = []
  count = 1
  
  while drink["strIngredient#{count}"] do
    name = drink["strIngredient#{count}"]
    measurement = drink["strMeasure#{count}"]
    ingredient += measurement
    ingredient += name
    output << ingredient 
    ingredient = ''
    count += 1
  end
  return output
end

def get_random_num
  rand(4...300)
end

margarita = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita'
margarita_description = 'The margarita looks and feels oh-so-right whether you’re in a tuxedo or a bathing suit, sipping from a dainty glass or slurping from a giant plastic cup.'
mojito = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito'
mojito_description = 'A classic Island drink of fresh lime and sweet muddled mint, the Mojito became a favorite during the Prohibition era when rum flights would carry thirsty travellers from Miami to Havana under the cover of night.'
manhattan = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=manhattan'
manhattan_description = 'The Manhattan was the most famous cocktail in the world shortly after it was invented in New York City’s Manhattan Club, some time around 1880 (as the story goes).'
gin = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=gin'
gin_description = "Despite strong ties to Britain, where gin was popularized centuries ago, the spirit actually originated in Holland. Legend has it that during the Thirty Years' War, British soldiers noticed the warming, calming effects that gin had on the Dutch soldiers who drank it. This eventually led to the phrase 'Dutch Courage'."
vodka = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=vodka'
vodka_description = 'Vodka is the most subtle of all the spirits so it takes a lot more searching to find the notes and characteristics that make them unique'
tequila = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=tequila';
tequila_description = "You won't remember."



initial_parse(margarita, margarita_description)
initial_parse(mojito, mojito_description )
initial_parse(manhattan, manhattan_description)
initial_parse(gin, gin_description)
initial_parse(vodka, vodka_description)
initial_parse(tequila, tequila_description)



User.find_or_create_by(name: 'Markus', username: 'markusThunder', password: '1234', age: 24, bar_cart:  ['cocktail glasses', 'shaker' ] )

Drink.find_or_create_by(name: "Massimo Bond Cocktail", image_url: 'https://cdn.liquor.com/wp-content/uploads/2019/07/22142929/The-Best-Dirty-Martini-You%E2%80%99re-Never-Going-to-Actually-Be-Able-to-Drink-720x720-article.jpg', 
ingredients:  ['2 oz Olive oil gin', '1⁄4 oz Mancino secco vermouth or Martini extra dry Italian vermouth', '3 drops Pink Himalayan salt solution', '4 leaves Sage', 'Olive', 'Sage Leaves' ], 
  directions:  'Add the sage leaves into a mixing glass and crush slightly with a muddler. Add the olive oil gin, vermouth, salt solution and ice and stir. Strain into a chilled coupe. Garnish with a skewered Taggiasca olive and 3 sage leaves. *Olive oil gin: Combine 750 mL gin and 200 mL extra-virgin olive oil (such as Villa Manodori Taggiasca extra-virgin olive oil) in a Mason jar with a seal-proof lid. Shake mixture, then leave at room temperature for 7-9 hours to allow flavors to infuse. Place jar in the freezer overnight to solidify fats. The next day, use a knife to break up coagulated fat at top of jar and strain spirit through a coffee filter or a cheese cloth. Strain again as desired to remove any leftover fat. Reserve in bottle until ready to use. **Pink Himalayan salt solution: Add 1/2 cup pink Himalayan salt and 1/2 cup water into a small bowl. Stir until salt dissolves and reserve.',
  tools: ['Coupe'], 
  description:  'Manuel Mora, the bar supervisor at Torno Subito in Dubai, devised a cocktail list that leans heavily on Italian ingredients, such as a blend of olive oils he uses in this riff on the classic Dry Martini that calls for Bottura’s very own Villa Manodori Taggiasca extra-virgin olive oil. This recipe originally appeared as part of “The Best Dirty Martini You’re Never Going to Actually Be Able to Drink.”', favorited_count: 7
)

Drink.find_or_create_by(name: 'Delete That Text', image_url: 'https://cdn.liquor.com/wp-content/uploads/2019/07/08124956/delete-that-text-720x720-recipe.jpg',
 ingredients:  ['4 Fresh blackberries', '1 oz Vodka', '1 oz Gin', '1⁄2 oz Elderflower liqueur', '3⁄4 oz Fresh lemon juice' ], 
 directions:  'Muddle the blackberries in a shaker. Add remaining ingredients and ice and shake until well-chilled. Double-strain into a double Old Fashioned glass over fresh ice. Garnish with a rosemary sprig and lemon peel.'  , 
 tools: ['Double Old Fashioned'], 
 description:  'Patrick Cook, the beverage director at Hyperion Public in Studio City, Calif., uses vodka to even out this blackberry sour, which seemed a little too ginny. "I was in love with the drink, but it was almost too botanical and becoming unbalanced," he says. "I knew that I still wanted to have two ounces of spirit but maybe dial it back just a touch." Tweaking the ratio to equal-parts gin and vodka did the trick. This recipe originally appeared as part of "Use Vodka to Boost the Flavor and Body of Your Cocktails. This Is How You Do It."'  ,
 favorited_count: 15
)

Drink.find_or_create_by(name: 'Whiskey Smash', image_url: 'https://cdn.liquor.com/wp-content/uploads/2017/08/03111040/11-Essential-Cocktails-for-your-August-Parties-whiskey-smash-720x720-slideshow.jpg', 
  ingredients:  ['3 wedges Lemon', '4 Mint leaves', '3⁄4 oz Simple syrup', '2 oz Bourbon', 'Mint Sprig'], 
  directions:  'Muddle the lemon in a shaker. Add the remaining ingredients and ice and shake. Double-strain into a rocks glass over one large ice cube. Slap a mint sprig between your hands and use as garnish. Serve with a straw.'  , 
  tools: ['rocks'], 
  description:  'Like Mint Juleps? You’ll love the Whiskey Smash, a citrusy 19th-century cooler. The citrus-and-mint combination are the perfect cocktail for those who say they’ll never drink whiskey.'  , favorited_count: 13
)


Drink.find_or_create_by(name: 'Old Fashioned', image_url: 'https://cdn.liquor.com/wp-content/uploads/2017/09/29103812/4-Rules-for-Drinking-Scotch-old-fashioned-720x720-slideshow.jpg', 
  ingredients:  ['2 oz Bourbon', '1/2 tsp White sugar', '3 dashes Angostura bitters', '1 dash Regan Orange Bitters No. 6', '1/4 oz Cold water', '1 Brown sugar cube', 'Lemon', 'Orange twists'], 
  directions:  'Add all ingredients into a mixing glass, muddle to break down the sugar and stir briefly. Fill with ice and stir again. Strain into a rocks glass over ice. Twist slices of lemon and orange peel over the drink to express the oil and drop them in.'  , 
  tools: ['rocks'], 
  description:  'The Old Fashioned cocktail is old-school but never out of fashion.' , favorited_count: 11
)

Drink.find_or_create_by(name: 'Gin Martini', 
  image_url: 'http://www.pamperedchef.com/iceberg/com/recipe/1445571-lg.jpg', 
  ingredients: ['3 ounces gin (or vodka)' '1/2 ounce dry vermouth' '1 lemon twist or 3 olives skewered on a cocktail pick, for garnish'] , 
  directions:  'Pour gin and vermouth into a shaker filled with ice. Stir and strain into a martini glass. Garnish with lemon twist or olives.'  , 
  tools:  ['martini glass', 'shaker' ], 
  description:  'The classic martini was made as a gin cocktail, but you can substitute for vodka if preferred.'  , 
  favorited_count: 18
)


Favorite.find_or_create_by(user_id: 1, drink_id: 3)
Favorite.find_or_create_by(user_id: 1, drink_id: 2)
Favorite.find_or_create_by(user_id: 1, drink_id: 5)
