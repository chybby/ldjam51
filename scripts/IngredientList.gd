extends Node

const Ingredient = preload("res://scripts/Ingredient.gd")

#TODO: this is awful but apparently dicts in gdscript aren't great either.

var ingredient_counts = Array()

func add_ingredient(ingredient: Ingredient, count = 1):
    for ingredient_count in ingredient_counts:
        var existing_ingredient = ingredient_count[0]
        if existing_ingredient.equals(ingredient):
            if ingredient.is_unique:
                return
            ingredient_count[1] += count
            return

    # Add ingredient not already present.
    var ingredient_count = Array()
    ingredient_count.append(ingredient.clone())
    if ingredient.is_unique:
        count = 1
    ingredient_count.append(count)
    ingredient_counts.append(ingredient_count)

func get_ingredients():
    return ingredient_counts

func blend():
    var old_ingredient_counts = ingredient_counts
    ingredient_counts = Array()
    for ingredient_count in old_ingredient_counts:
        ingredient_count[0].blend()
        add_ingredient(ingredient_count[0], ingredient_count[1])

func froth():
    var old_ingredient_counts = ingredient_counts
    ingredient_counts = Array()
    for ingredient_count in old_ingredient_counts:
        ingredient_count[0].froth()
        add_ingredient(ingredient_count[0], ingredient_count[1])

func combine(other):
    for ingredient_count in other.ingredient_counts:
        add_ingredient(ingredient_count[0], ingredient_count[1])

func is_empty():
    return ingredient_counts.is_empty()

func _to_string():
    var keys_and_values = Array()
    for ingredient_count in ingredient_counts:
        keys_and_values.append("%s:%s" % ingredient_count)
    return "{%s}" % ', '.join(keys_and_values)

func equals(other):
    if other.ingredient_counts.size() != ingredient_counts.size():
        return false

    for ingredient_count in other.ingredient_counts:
        if not has_ingredient_with_count(ingredient_count[0], ingredient_count[1]):
            return false

    return true

func mix_colors(colors):
    var r = 0
    var g = 0
    var b = 0
    var k = 0
    var count = 0
    for color in colors:
        r += color.r * 255
        g += color.g * 255
        b += color.b * 255
        count += 1
    if count == 0:
        return Color8(255, 255, 255)

    return Color8(int(r/count), int(g/count), int(b/count))

func get_color():
    if ingredient_counts.size() == 0:
        return Color8(255, 255, 255)
    var colors = Array()
    for ingredient_count in ingredient_counts:
        for i in ingredient_count[1]:
            colors.append(ingredient_count[0].get_color())
    return mix_colors(colors)

func get_blended_color():
    if ingredient_counts.size() == 0:
        return Color8(255, 255, 255)
    var colors = Array()
    for ingredient_count in ingredient_counts:
        if ingredient_count[0].blended:
            for i in ingredient_count[1]:
                colors.append(ingredient_count[0].get_color())
    return mix_colors(colors)

func get_unblended_color():
    if ingredient_counts.size() == 0:
        return Color8(255, 255, 255)
    var colors = Array()
    for ingredient_count in ingredient_counts:
        if not ingredient_count[0].blended:
            for i in ingredient_count[1]:
                colors.append(ingredient_count[0].get_color())
    return mix_colors(colors)

func has_ingredient(ingredient):
    for ingredient_count in ingredient_counts:
        if ingredient_count[0].equals(ingredient):
            return true

    return false

func get_ingredient_count(ingredient):
    for ingredient_count in ingredient_counts:
        if ingredient_count[0].equals(ingredient):
            return ingredient_count[0]
    return -1

func has_ingredient_with_count(ingredient, count):
    for ingredient_count in ingredient_counts:
        if ingredient_count[0].equals(ingredient):
            return ingredient_count[1] == count

    return false
