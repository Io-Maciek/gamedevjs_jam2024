GDPC                                                                                          T   res://.godot/exported/133200997/export-4e8c3ac095851cd7f9b0c2ba6b10aaf9-player.scn                
fLS�u��8yhu    T   res://.godot/exported/133200997/export-850454f34ca932024817aa3644773966-level1.scn               ������g%�	�ޒ
R    ,   res://.godot/global_script_class_cache.cfg  �!             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexP      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  �%      �       #�\�Am���>��#��    (   res://Scenes/Prefabs/player.tscn.remap   !      c       ��7��.���S�n�)�        res://Scenes/level1.tscn.remap  p!      c       � 4Wk�
>94��S��"        res://Scripts/player_movement.gd@            *H��[��P	^1����       res://icon.svg   "      �      C��=U���^Qu��U3       res://icon.svg.import   0       �       ��⽈�z��<*ID4�       res://project.binary�&      �      ��������}C$ԉظ                RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    radius    height    radial_segments    rings    script    custom_solver_bias    margin 	   _bundled       Script !   res://Scripts/player_movement.gd ��������      local://CapsuleMesh_3spyl          local://CapsuleShape3D_iubs1 8         local://PackedScene_sh1gc W         CapsuleMesh             CapsuleShape3D             PackedScene          	         names "         Player    script    CharacterBody3D 	   Camera3D 
   transform    current    MeshInstance3D    mesh    CollisionShape3D    shape    AnimationPlayer    	   variants                      �?              �?              �?      @?                                   node_count             nodes     -   ��������       ����                            ����                                 ����                           ����   	                  
   
   ����              conn_count              conns               node_paths              editable_instances              version             RSRC  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    size    subdivide_width    subdivide_depth    center_offset    orientation    script    custom_solver_bias    margin 	   _bundled       PackedScene !   res://Scenes/Prefabs/player.tscn o>Ѭ�k/      local://PlaneMesh_vwggn :         local://BoxShape3D_nlenn T         local://PackedScene_dau2g �      
   PlaneMesh             BoxShape3D          �?��.=�3�?         PackedScene          	         names "         Node 
   GameScene    Node3D    Player 
   transform    DirectionalLight3D    MeshInstance3D    mesh    StaticBody3D    CollisionShape3D    shape    	   variants                      �?              �?              �?    6��?         �?            �]�>�p?    �p��]�>    ��/A         �@              �@              �@                           �?              �?              �?                           node_count             nodes     =   ��������        ����                      ����               ���                                 ����                          ����                                ����               	   	   ����         
                conn_count              conns               node_paths              editable_instances              version             RSRC    extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouseAccumulatedMovement = Vector2(0, 0)
@export var mouseSensitivity = 0.1
@export var gamepadSensitivity =  4.0
@onready var camera = $Camera3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion: 
		mouseAccumulatedMovement += event.relative

func _physics_process(delta):
	MouseMovement(delta)
	Movement(delta)

func MouseMovement(delta):
	var gamepadMovement = Input.get_vector("gamepad_look_up", "gamepad_look_down", "gamepad_look_left", "gamepad_look_right")
	
	rotation_degrees = Vector3(
		rotation_degrees.x,
		rotation_degrees.y - (mouseAccumulatedMovement.x * mouseSensitivity) - (gamepadMovement.y* gamepadSensitivity),
		rotation_degrees.z
	)
	
	
	
	#moving only camera child in player object up and down
	camera.rotation_degrees = Vector3(
		clamp(
			camera.rotation_degrees.x - (mouseAccumulatedMovement.y * mouseSensitivity)
				- (gamepadMovement.y * gamepadSensitivity),
			-90, 
			90
		),
		camera.rotation_degrees.y,
		camera.rotation_degrees.z)
	mouseAccumulatedMovement = Vector2(0, 0)

func Movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("go_left", "go_right", "go_forward", "go_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
             GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bmyis4qs8akmj"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                [remap]

path="res://.godot/exported/133200997/export-4e8c3ac095851cd7f9b0c2ba6b10aaf9-player.scn"
             [remap]

path="res://.godot/exported/133200997/export-850454f34ca932024817aa3644773966-level1.scn"
             list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             ��� �v�-   res://icon.svg���n
eF   res://level1.tscno>Ѭ�k/   res://player.tscn���n
eF   res://Scenes/level1.tscno>Ѭ�k/   res://Scenes/player.tscno>Ѭ�k/    res://Scenes/Prefabs/player.tscn    ECFG      application/config/name         gamedevjs_jam2024      application/run/main_scene          res://Scenes/level1.tscn   application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg     input/go_forward�              events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script            deadzone      ?   input/go_back�              events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script            deadzone      ?   input/go_left�              events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script            deadzone      ?   input/go_right�              events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script            deadzone      ?
   input/jump�              events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script            deadzone      ?   input/gamepad_look_up�               events              InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       ��   script            deadzone      ?   input/gamepad_look_down�               events              InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       �?   script            deadzone      ?   input/gamepad_look_left�               events              InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       ��   script            deadzone      ?   input/gamepad_look_right�               events              InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       �?   script            deadzone      ?#   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility4   rendering/textures/vram_compression/import_etc2_astc                        