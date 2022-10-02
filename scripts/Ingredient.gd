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

func debug_string():
    var ingredient_desc
    match ingredient_type:
        IngredientType.ESPRESSO_SHOT: ingredient_desc = 'espresso'
        IngredientType.HOT_WATER: ingredient_desc = 'hot water'
        IngredientType.ICE: ingredient_desc = 'ice'
        IngredientType.CARAMEL_SYRUP: ingredient_desc = 'caramel syrup'
        IngredientType.HAZELNUT_SYRUP: ingredient_desc = 'hazelnut syrup'
        IngredientType.VANILLA_SYRUP: ingredient_desc = 'vanilla syrup'
        IngredientType.WHOLE_MILK: ingredient_desc = 'whole milk'
        IngredientType.SKIMMED_MILK: ingredient_desc = 'skimmed milk'
        IngredientType.OAT_MILK: ingredient_desc = 'oat milk'
        IngredientType.SOY_MILK: ingredient_desc = 'soy milk'
        IngredientType.MANGO: ingredient_desc = 'mango'
        IngredientType.STRAWBERRY: ingredient_desc = 'strawberry'
        IngredientType.BANANA: ingredient_desc = 'banana'
        IngredientType.WHIPPED_CREAM: ingredient_desc = 'whipped cream'

    return "[%s b=%s f=%s]" % [ingredient_desc, blended, frothed]

func _to_string():
    return debug_string()

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
