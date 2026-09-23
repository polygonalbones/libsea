const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const crt1 = b.addObject(.{
        .name = "crt1",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/crt1.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const install_crt1 = b.addInstallFile(crt1.getEmittedBin(), "lib/crt1.o");
    b.getInstallStep().dependOn(&install_crt1.step);

    const lib = b.addLibrary(.{
        .name = "sea",
        .linkage = .static,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/libsea.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(lib);
}
