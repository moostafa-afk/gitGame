#*
#* health.gd
#* =============================================================================
#* Copyright (c) 2023-present Serhii Snitsaruk and the LimboAI contributors.
#*
#* Use of this source code is governed by an MIT-style
#* license that can be found in the LICENSE file or at
#* https://opensource.org/licenses/MIT.
#* =============================================================================
#*
class_name Health
extends Node
## Tracks health and emits signal when damaged or dead.

## Emitted when health is reduced to 0.
signal death

## Emitted when health is damaged.
signal damaged(amount: float, knockback: Vector2)

## Initial health value.
@export var max_health: float = 100.0

var current_health: float


func _ready() -> void:
    current_health = max_health


func take_damage(amount: float, knockback: Vector2) -> void:
    #print(amount)
    #print(current_health)
    if current_health <= 0.0:
        return

    current_health -= amount
    current_health = max(current_health, 0.0)

    if current_health <= 0.0:
        death.emit()
    else:
        damaged.emit(amount, knockback)


## Returns current health.
func getcurrent_health() -> float:
    return current_health
