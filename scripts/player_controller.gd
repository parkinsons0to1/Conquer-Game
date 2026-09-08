extends CharacterBody3D

# --- Movement Parameters ---
@export var walk_speed: float = 4.5
@export var sprint_speed: float = 8.0
@export var jump_velocity: float = 7.0
@export var rotation_speed: float = 12.0
@export var mouse_sensitivity: float = 0.003
@export var controller_sensitivity: float = 2.5

# --- Vitals (Survival) ---
@export var max_health: float = 100.0
var health: float = 100.0

@export var max_stamina: float = 100.0
var stamina: float = 100.0

@export var max_hunger: float = 100.0
var hunger: float = 100.0

# Node References
@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/SpringArm3D/Camera3D
@onready var visual_model: Node3D = $Visuals
@onready var spear_mount: Node3D = $Visuals/RightHandMount

# Internal State
var gravity: float = 19.6
var is_sprinting: bool = false
var is_attacking: bool = false
var attack_timer: float = 0.0

func _ready() -> void:
	# Capture mouse for intuitive 3D camera control
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_setup_fallback_inputs()

func _setup_fallback_inputs() -> void:
	# Ensure default input actions exist programmatically
	_add_key_action("move_forward", KEY_W, JOY_AXIS_LEFT_Y, -1.0)
	_add_key_action("move_back", KEY_S, JOY_AXIS_LEFT_Y, 1.0)
	_add_key_action("move_left", KEY_A, JOY_AXIS_LEFT_X, -1.0)
	_add_key_action("move_right", KEY_D, JOY_AXIS_LEFT_X, 1.0)
	_add_btn_action("jump", KEY_SPACE, JOY_BUTTON_A)
	_add_btn_action("sprint", KEY_SHIFT, JOY_BUTTON_LEFT_STICK)
	_add_btn_action("attack", MOUSE_BUTTON_LEFT, JOY_BUTTON_RIGHT_SHOULDER)

func _add_key_action(action: String, keycode: Key, axis: JoyAxis, axis_val: float) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
		var ev_key = InputEventKey.new()
		ev_key.physical_keycode = keycode
		InputMap.action_add_event(action, ev_key)
		var ev_joy = InputEventJoypadMotion.new()
		ev_joy.axis = axis
		ev_joy.axis_value = axis_val
		InputMap.action_add_event(action, ev_joy)

func _add_btn_action(action: String, key_or_mouse, joy_btn: JoyButton) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
		if key_or_mouse is Key:
			var ev_key = InputEventKey.new()
			ev_key.physical_keycode = key_or_mouse
			InputMap.action_add_event(action, ev_key)
		elif key_or_mouse is MouseButton:
			var ev_mouse = InputEventMouseButton.new()
			ev_mouse.button_index = key_or_mouse
			InputMap.action_add_event(action, ev_mouse)
		var ev_joy = InputEventJoypadButton.new()
		ev_joy.button_index = joy_btn
		InputMap.action_add_event(action, ev_joy)

func _unhandled_input(event: InputEvent) -> void:
	# Toggle mouse capture with Escape
	if event is InputEventKey and event.pressed and event.physical_keycode == KEY_ESCAPE:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# Mouse Camera Orbit
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camera_pivot.rotate_y(-event.relative.x * mouse_sensitivity)
		var spring_arm = camera_pivot.get_node("SpringArm3D")
		spring_arm.rotate_x(-event.relative.y * mouse_sensitivity)
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(-70.0), deg_to_rad(50.0))

func _physics_process(delta: float) -> void:
	_handle_controller_look(delta)
	_handle_vitals(delta)
	_handle_movement(delta)
	_handle_attack(delta)

func _handle_controller_look(delta: float) -> void:
	# Xbox Right Stick Camera Orbit (Axis 2 = Horizontal, Axis 3 = Vertical)
	var right_x = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	var right_y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
	
	if abs(right_x) > 0.15:
		camera_pivot.rotate_y(-right_x * controller_sensitivity * delta)
	if abs(right_y) > 0.15:
		var spring_arm = camera_pivot.get_node("SpringArm3D")
		spring_arm.rotate_x(-right_y * controller_sensitivity * delta)
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(-70.0), deg_to_rad(50.0))

func _handle_movement(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Sprint logic & Stamina check
	var wants_sprint = Input.is_action_pressed("sprint")
	is_sprinting = wants_sprint and stamina > 5.0 and is_on_floor()
	var current_speed = sprint_speed if is_sprinting else walk_speed

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if stamina >= 10.0:
			velocity.y = jump_velocity
			stamina -= 10.0

	# Direction vector from Input
	var input_x = Input.get_axis("move_left", "move_right")
	var input_y = Input.get_axis("move_back", "move_forward")
	var input_dir = Vector2(input_x, input_y)

	# Transform input relative to Camera's yaw angle
	var cam_yaw = camera_pivot.global_transform.basis.get_euler().y
	var move_dir = Vector3(input_dir.x, 0, -input_dir.y).rotated(Vector3.UP, cam_yaw).normalized()

	if move_dir.length() > 0.1:
		velocity.x = move_dir.x * current_speed
		velocity.z = move_dir.z * current_speed
		
		# Smoothly rotate visual mesh towards moving direction
		var target_rotation = atan2(-move_dir.x, -move_dir.z)
		visual_model.rotation.y = lerp_angle(visual_model.rotation.y, target_rotation, rotation_speed * delta)
		
		if is_sprinting:
			stamina = max(0.0, stamina - 18.0 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed * 8.0 * delta)
		velocity.z = move_toward(velocity.z, 0, current_speed * 8.0 * delta)

	move_and_slide()

func _handle_vitals(delta: float) -> void:
	# Passive stamina recovery when not sprinting
	if not is_sprinting and is_on_floor():
		stamina = min(max_stamina, stamina + 15.0 * delta)

	# Hunger decay over time
	hunger = max(0.0, hunger - 0.5 * delta)

func _handle_attack(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and not is_attacking and spear_mount:
		is_attacking = true
		attack_timer = 0.35

	if is_attacking:
		attack_timer -= delta
		# Thrust spear forward
		if spear_mount:
			spear_mount.position.z = -0.3 * sin((0.35 - attack_timer) / 0.35 * PI)
		if attack_timer <= 0.0:
			is_attacking = false
			if spear_mount:
				spear_mount.position.z = 0.0
