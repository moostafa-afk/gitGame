#*
#* hurtbox.gd
#* =============================================================================
#* Copyright (c) 2023-present Serhii Snitsaruk and the LimboAI contributors.
#*
#* Use of this source code is governed by an MIT-style
#* license that can be found in the LICENSE file or at
#* https://opensource.org/licenses/MIT.
#* =============================================================================
#*
class_name Hurtbox
extends Area2D
## Area that registers damage.

@onready var health: Health = %Health

var last_attack_vector: Vector2


func take_damage(amount: float, knockback: Vector2, source: Node2D) -> void:
## Important change the name of the below t
    #if source.owner.name == "laser_sprite_group":
        #return
    #else:
        last_attack_vector = owner.global_position - source.owner.global_position
        health.take_damage(amount, knockback)
        owner.velocity.x = knockback.x / last_attack_vector.x * 100
