package main

import (
	"fmt"
)

//Struct
type Bread struct {
	name        string
	ingredients map[string]Item
	weight      float32
	baking      Baking
}
type Item struct {
	weight int
}

type Baking struct {
	bakeTime    int
	coolTime    int
	temperature int
}

//interface
type Baker interface {
	shoppingList(ingredients map[string]Item) (shopList map[string]Item)
	printBakeInstructions()
	printBreadInfo()
}

func printBakeInstructions() {

}

func printBreadInfo() {

}

func main() {

	var ingMap = make(map[string]Item)
	ingMap["raisin"] = Item{99}

	var ingMap2 = make(map[string]Item)
	ingMap["sugar"] = Item{50}

	b := NewBreadVariation("WholeWeat bread", ingMap, ingMap2)

	fmt.Println(b.name)
	fmt.Println(b.ingredients)
	fmt.Println("Weight " ,b.weight,"kg")

}

func NewBread() *Bread {
	var bread Bread
	b := &bread

	b.name = "Whole Wheat"
	b.ingredients = make(map[string]Item)

	b.ingredients["whole wheat flour"] = Item{500}
	b.ingredients["yeast"] = Item{25}
	b.ingredients["salt"] = Item{25}
	b.ingredients["sugar"] = Item{50}
	b.ingredients["butter"] = Item{50}
	b.ingredients["water"] = Item{350}
	b.baking.bakeTime = 2
	b.baking.temperature = 180
	b.baking.coolTime = 1
	b.weight = 0

	for k := range b.ingredients {
		b.weight += float32(b.ingredients[k].weight)
	}
	return b

}

func NewBreadVariation(n string, ingredientsToAdd map[string]Item,
	ingredientsToRemove map[string]Item) *Bread {

	b := NewBread()
	b.name = n

	//Added ingredients
	if len(ingredientsToAdd) > 0 {
		for k, v := range ingredientsToAdd {
			//If the ingredient already exists, just add the weight of the item
			if val, ok := b.ingredients[k]; ok {
				val.weight += ingredientsToAdd[k].weight
			} else {
				//Ingredient doesn't exist, add to the ingredient list
				b.ingredients[k] = v
			}
		}
	}

	//Removed ingredients
	if len(ingredientsToRemove) > 0 {
		for k := range ingredientsToRemove {
			//If the ingredient already exists, just subtract the weight of the item
			if val, ok := b.ingredients[k]; ok {
				val.weight -= ingredientsToRemove[k].weight
			}
		}
	}

	//Recalculate 
	b.weight = 0
	for k := range b.ingredients {
		b.weight += float32(b.ingredients[k].weight)
	}
	return b
}
