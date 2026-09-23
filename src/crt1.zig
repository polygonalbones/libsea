const builtin = @import("builtin");

extern fn main() callconv(.c) noreturn;
extern fn __libsea_init() callconv(.c) noreturn;

export fn _start() callconv(.naked) noreturn {
    asm volatile(
        \\ movq %%rsp, %%rdi
        \\ jmp %[init:P]
        :
        : [main_fn] "{rsi}" (&main),
          [init] "X" (&__libsea_init),
    );
}
