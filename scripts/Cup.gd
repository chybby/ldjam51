extends "res://scripts/HoldableItem.gd"

const IngredientList = preload("res://scripts/IngredientList.gd")
const Ingredient = preload("res://scripts/Ingredient.gd")
const Milk = preload("res://scripts/Milk.gd")
const WhippedCream = preload("res://scripts/WhippedCream.gd")
const MilkJug = preload("res://scripts/MilkJug.gd")
const BlenderJug = preload("res://scripts/BlenderJug.gd")

enum CupSize {SMALL, MEDIUM, LARGE}

@onready var cup_sprite = $Sprite3d
@onready var contents = $Contents
@onready var whipped_cream = $WhippedCream

var ingredients = IngredientList.new()
var size = CupSize.MEDIUM

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    item_name = "%s Cup" % size_name()

    var sprite_path = get_sprite_path()
    var image = Image.load_from_file(sprite_path)
    var texture = ImageTexture.create_from_image(image)
    cup_sprite.texture = texture

func size_name():
    match size:
        CupSize.SMALL:
            return "Small"
        CupSize.MEDIUM:
            return "Medium"
        CupSize.LARGE:
            return "Large"

func on_interact(character, item, _interact_position):
    if item != self:
        return

    print('%s cup interacted with' % self)

    var held_item = character.get_held_item()
    if held_item is Milk or held_item is WhippedCream:
        if(held_item is WhippedCream):
             held_item.play_sound()
        self.add_ingredient(held_item.ingredient.clone())
    elif (held_item is MilkJug or held_item is BlenderJug) and held_item.has_contents():
        # Don't let unblended ingredients go into the cup
        if held_item is BlenderJug and held_item.has_unblended_contents():
            return
        ingredients.combine(held_item.take_contents())
        contents.visible = true
        $SoundCupPour.play()
        print('Cup has ingredients: %s' % ingredients)
    else:
        hold_or_swap(character)

func add_ingredient(ingredient):
    contents.visible = true
    if ingredient.ingredient_type == Ingredient.IngredientType.WHIPPED_CREAM:
        whipped_cream.visible = true
    ingredients.add_ingredient(ingredient)
    $SoundCupPour.play()
    print('Cup has ingredients: %s' % ingredients)

func get_sprite_path():
    match size:
        CupSize.SMALL: return 'res://assets/empty_small_cup.png'
        CupSize.MEDIUM: return 'res://assets/emptymediumcup.png'
        CupSize.LARGE: return 'res://assets/empty_large_cup.png'

func get_icon_path():
    match size:
        CupSize.SMALL: return 'res://assets/smallcup.png'
        CupSize.MEDIUM: return 'res://assets/mediumcup.png'
        CupSize.LARGE: return 'res://assets/largecup.png'

func get_size():
    return size

func set_size(new_size):
    self.size = new_size

    # var child_scale
    # match new_size:
    #     CupSize.SMALL:
    #         child_scale = 0.6
    #     CupSize.MEDIUM:
    #         child_scale = 1
    #     CupSize.LARGE:
    #         child_scale = 1.4
    # $Model.scale = Vector3.ONE * child_scale
    # $Model.position *= child_scale
    # $Collision.scale = Vector3.ONE * child_scale
    # $Collision.position *= child_scale

    item_name = "%s Cup" % size_name()

    if cup_sprite:
        var sprite_path = get_sprite_path()
        var image = Image.load_from_file(sprite_path)
        var texture = ImageTexture.create_from_image(image)
        cup_sprite.texture = texture


func put_down():
    super()
    contents.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
    whipped_cream.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y

func pick_up():
    super()
    contents.billboard = BaseMaterial3D.BILLBOARD_ENABLED
    whipped_cream.billboard = BaseMaterial3D.BILLBOARD_ENABLED
