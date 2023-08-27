class_name Power
extends Resource

enum powerValues {None, Force, Tech}
enum castingPeriodValues {None, Action, BonusAction, Reaction, Minute, Hour}
enum forceAlignmentValues {None, Universal, Dark, Light}
@export var name: String
@export var powerType: powerValues
@export var prerequisite: String
@export var level: int
@export var castingPeriod: castingPeriodValues
@export var powerRange: String
@export var duration: String
@export var concentration: bool
@export var forceAlignment: forceAlignmentValues
@export var description: String
@export var higherLevelDescription: String
