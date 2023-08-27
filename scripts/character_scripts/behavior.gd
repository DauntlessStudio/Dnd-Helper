class_name Behavior
extends Resource

enum behaviorValues {Trait, Action, Reaction, Legendary}
enum attackValues {None, MeleeWeapon, RangedWeapon}
enum damageTypeValues {Unknown, Acid, Cold, Energy, Fire, Force, Ion, Kinetic, Lightning, Necrotic, Poison, Psychic, Sonic}
@export var name: String
@export var monsterBehaviorType: behaviorValues
@export var description: String
@export var descriptionWithLinks: String
@export var attackType: attackValues
@export var restrictions: String
@export var range: String
@export var attackBonus: int
@export var numberOfTargets: String
@export var damage: int
@export var damageRoll: String
@export var damageType: damageTypeValues
