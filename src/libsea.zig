const builtin = @import("builtin");

const MainFn = *const fn (argc: c_int, argv: [*][*:0]u8) callconv(.c) i32;

export fn __libsea_init(sp: [*]usize, main_fn: MainFn) callconv(.c) void {
    const argc: c_int = @intCast(sp[0]);
    const argv: [*][*:0]u8 = @ptrCast(sp + 1);
    
    const rc = main_fn(argc, argv);
    exit(rc);
}

fn exit(rc: i32) noreturn {
    switch(builtin.cpu.arch) {
        .x86_64 => asm volatile(
            \\ syscall
            :
            : [number] "{rax}" (@as(usize, 231)),
              [arg1] "{rdi}" (rc),
            : .{ .rcx = true, .r11 = true, .memory = true }
        ),
        else => @compileError("unsupported arch"),
    }
    unreachable;
}
