extends Camera3D
class_name InterpolatedCamera3D

# The factor to use for asymptotical translation lerping.
# If 0, the camera will stop moving. If 1, the camera will move instantly.
@export_range(0, 1, 0.001) var translate_speed := 0.95

# The factor to use for asymptotical rotation lerping.
# If 0, the camera will stop rotating. If 1, the camera will rotate instantly.
@export_range(0, 1, 0.001) var rotate_speed := 0.95

# The factor to use for asymptotical FOV lerping.
# If 0, the camera will stop changing its FOV. If 1, the camera will change its FOV instantly.
# Note: Only works if the target node is a Camera3D.
@export_range(0, 1, 0.001) var fov_speed := 0.95

# The factor to use for asymptotical Z near/far plane distance lerping.
# If 0, the camera will stop changing its Z near/far plane distance. If 1, the camera will do so instantly.
# Note: Only works if the target node is a Camera3D.
@export_range(0, 1, 0.001) var near_far_speed := 0.95

# Node to target
@export var target: Node3D

# The offset to the target
@export var offset_to_target: Vector3

func _process(delta: float) -> void:
	assert(target is Node3D, "Error: Need a target to follow")

	var translate_factor := 1 - pow(1 - translate_speed, delta * 3.45233)
	var rotate_factor := 1 - pow(1 - rotate_speed, delta * 3.45233)
	var target_xform := target.get_global_transform()
	target_xform.origin += offset_to_target

	var local_transform_only_origin := Transform3D(Basis(), get_global_transform().origin)
	var local_transform_only_basis := Transform3D(get_global_transform().basis, Vector3())
	local_transform_only_origin = local_transform_only_origin.interpolate_with(target_xform, translate_factor)
	
	local_transform_only_basis = local_transform_only_basis.interpolate_with(target_xform.looking_at(target.position), rotate_factor)
	set_global_transform(Transform3D(local_transform_only_basis.basis, local_transform_only_origin.origin))
