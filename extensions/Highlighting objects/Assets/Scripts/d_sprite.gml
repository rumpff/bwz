/// d_sprite(sprite, imgn, x, y, scale, rotate, outl)
surface_set_target(global.outl)
shader_set(sh_alpha)
draw_sprite_ext(argument0, argument1, argument2*o_cont.outl_scale, argument3*o_cont.outl_scale, argument4*o_cont.outl_scale, argument4*o_cont.outl_scale, argument5, argument6, 1)
shader_reset()
surface_reset_target()

draw_sprite_ext(argument0, argument1, argument2, argument3, argument4, argument4, argument5, c_white, 1)

