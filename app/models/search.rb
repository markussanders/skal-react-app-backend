require 'rest-client'
require 'json'
require 'faker'


class Search < ApplicationRecord
    belongs_to :user

    BASE_URL = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s='

    def self.search_for(term) 
        response = RestClient.get(BASE_URL + term)
        p 'response = '
        p response
        json = JSON.parse(response)
        p 'json = '
        p json
        json["drinks"].map { |drink| 
            new_drink = Drink.find_or_create_by(name: drink["strDrink"])
            new_drink.update(tools: [drink["strGlass"]])
            new_drink.update(directions: drink["strInstructions"])
            new_drink.update(image_url: drink["strDrinkThumb"])
            ingredients = self.get_ingredients(drink)
            true_ingredients = ingredients.filter{|ingredient| ingredient.length > 0}
            new_drink.update(ingredients: true_ingredients)
            fake_description = Faker::Lorem.sentence
            new_drink.update(description: fake_description, favorited_count: 0)
            new_drink
        }
    end

    def self.get_ingredients(drink)
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
end
