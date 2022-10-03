extends Node

# Some things create ingredients
# eg. Hot water dispenser creates hot water
# eg. Whole milk carton creates whole milk, it is frothable.
# eg. Mango creates mango, it is blendable

# Ingredients go into cups (and jugs)
# eg. a cup can have blended mango in it
# eg. a cup can have frothed or unfrothed oat milk

# Ingredients are listed in orders
# eg. an order can call for 3x frothed oat milk and 1x espresso shot

enum IngredientType {
    ESPRESSO_SHOT,
    HOT_WATER,
    ICE,
    CARAMEL_SYRUP,
    HAZELNUT_SYRUP,
    VANILLA_SYRUP,
    WHOLE_MILK,
    SKIMMED_MILK,
    OAT_MILK,
    SOY_MILK,
    MANGO,
    STRAWBERRY,
    BANANA,
    WHIPPED_CREAM,
}

var ingredient_type : IngredientType

var is_blendable = false  # Whether this gets blended in a blender.
var blended = false  # Whether this got blended in a blender.

var is_frothable = false  # Whether this gets frothed in a milk jug.
var frothed = false  # Whether this got frothed in a frother.

var is_unique = false  # Whether there can only be one in an order, eg. you can only put one whipped cream on a drink.

# Constructor
func _init(t : IngredientType, b = false, f = false, u = false):
    ingredient_type = t
    is_blendable = b
    is_frothable = f
    is_unique = u

func blend():
    if is_blendable:
        blended = true

func froth():
    if is_frothable:
        frothed = true

func icon_file_name():
    match ingredient_type:
        IngredientType.ESPRESSO_SHOT: return 'res://assets/coffee.png'
        IngredientType.HOT_WATER: return 'res://assets/water.png'
        IngredientType.ICE: return 'res://assets/icecube.png'
        IngredientType.CARAMEL_SYRUP: return 'res://assets/caramel.png'
        IngredientType.HAZELNUT_SYRUP: return 'res://assets/hazelnut.png'
        IngredientType.VANILLA_SYRUP: return 'res://assets/vanilla.png'
        IngredientType.WHOLE_MILK: return 'res://assets/whole_milk.png'
        IngredientType.SKIMMED_MILK: return 'res://assets/skimmed_milk.png'
        IngredientType.OAT_MILK: return 'res://assets/oat_milk.png'
        IngredientType.SOY_MILK: return 'res://assets/soy_milk.png'
        IngredientType.MANGO: return 'res://assets/mango.png'
        IngredientType.STRAWBERRY: return 'res://assets/strawberry.png'
        IngredientType.BANANA: return 'res://assets/banana.png'
        IngredientType.WHIPPED_CREAM: return 'res://assets/whipped_cream.png'

func get_flavour():
    match ingredient_type:
        IngredientType.ESPRESSO_SHOT: return ''
        IngredientType.HOT_WATER: return ''
        IngredientType.ICE: return ''
        IngredientType.CARAMEL_SYRUP: return ''
        IngredientType.HAZELNUT_SYRUP: return ''
        IngredientType.VANILLA_SYRUP: return ''
        IngredientType.WHOLE_MILK: return '"The entirety of milk"'
        IngredientType.SKIMMED_MILK: return '"Just the top of the milk"'
        IngredientType.OAT_MILK: return '"Milked from free-range oats"'
        IngredientType.SOY_MILK: return '"From cows that eat only soy beans"'
        IngredientType.MANGO: return '"S tier fruit"'
        IngredientType.STRAWBERRY: return '"Straws not included"'
        IngredientType.BANANA: return '"Not just for monkeys"'
        IngredientType.WHIPPED_CREAM: return '"It misbehaved"'

func get_color():
    match ingredient_type:
        IngredientType.ESPRESSO_SHOT: return Color8(69, 45, 29)
        IngredientType.HOT_WATER: return Color8(201,244,255)
        IngredientType.ICE: return Color8(201,244,255)
        IngredientType.CARAMEL_SYRUP: return Color8(230, 106, 30)
        IngredientType.HAZELNUT_SYRUP: return Color8(138, 46, 0)
        IngredientType.VANILLA_SYRUP: return Color8(242, 190, 121)
        IngredientType.WHOLE_MILK: return Color8(245, 216, 179)
        IngredientType.SKIMMED_MILK: return Color8(245, 216, 179)
        IngredientType.OAT_MILK: return Color8(245, 216, 179)
        IngredientType.SOY_MILK: return Color8(245, 216, 179)
        IngredientType.MANGO: return Color8(255, 60, 0)
        IngredientType.STRAWBERRY: return Color8(255, 61, 61)
        IngredientType.BANANA: return Color8(255, 210, 46)
        IngredientType.WHIPPED_CREAM: return Color8(245, 231, 181)

func get_name():
    var ingredient_desc
    match ingredient_type:
        IngredientType.ESPRESSO_SHOT: ingredient_desc = 'Espresso Shot'
        IngredientType.HOT_WATER: ingredient_desc = 'Hot Water'
        IngredientType.ICE: ingredient_desc = 'Ice'
        IngredientType.CARAMEL_SYRUP: ingredient_desc = 'Caramel Syrup'
        IngredientType.HAZELNUT_SYRUP: ingredient_desc = 'Hazelnut Syrup'
        IngredientType.VANILLA_SYRUP: ingredient_desc = 'Vanilla Syrup'
        IngredientType.WHOLE_MILK: ingredient_desc = 'Whole Milk'
        IngredientType.SKIMMED_MILK: ingredient_desc = 'Skimmed Milk'
        IngredientType.OAT_MILK: ingredient_desc = 'Oat Milk'
        IngredientType.SOY_MILK: ingredient_desc = 'Soy Milk'
        IngredientType.MANGO: ingredient_desc = 'Mango'
        IngredientType.STRAWBERRY: ingredient_desc = 'Strawberry'
        IngredientType.BANANA: ingredient_desc = 'Banana'
        IngredientType.WHIPPED_CREAM: ingredient_desc = 'Whipped Cream'

    return ingredient_desc

func _to_string():
    return "[%s b=%s f=%s]" % [get_name(), blended, frothed]

func clone():
    var cloned = get_script().new(ingredient_type, is_blendable, is_frothable, is_unique)
    if blended:
        cloned.blend()
    if frothed:
        cloned.froth()
    return cloned

func equals(other):
    if ingredient_type != other.ingredient_type:
        return false

    if is_blendable != other.is_blendable:
        return false
    if blended != other.blended:
        return false

    if is_frothable != other.is_frothable:
        return false
    if frothed != other.frothed:
        return false

    if is_unique != other.is_unique:
        return false

    return true
