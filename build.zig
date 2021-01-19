const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const fltkz_init = b.addSystemCommand(&[_][]const u8{
        "git",
        "submodule",
        "update",
        "--init",
        "--recursive",
    });
    try fltkz_init.step.make();

    const fltkz_config = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "-B",
        "vendor/bin",
        "-S",
        "vendor/cfltk",
        "-DCMAKE_BUILD_TYPE=Release",
        "-DCMAKE_INSTALL_PREFIX=vendor/lib",
        "-DFLTK_BUILD_TEST=OFF",
    });
    try fltkz_config.step.make();

    const fltkz_build = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "--build",
        "vendor/bin",
        "--config",
        "Release",
        "--parallel",
    });
    try fltkz_build.step.make();

    const fltkz_install = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "--install",
        "vendor/bin",
    });
    try fltkz_install.step.make();

    const exe = b.addExecutable("fltk_app", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.addIncludeDir("vendor/cfltk/include");
    exe.addLibPath("vendor/lib/lib");
    exe.linkSystemLibrary("cfltk");
    exe.linkSystemLibrary("fltk");
    exe.linkSystemLibrary("fltk_images");
    exe.linkSystemLibrary("fltk_png");
    exe.linkSystemLibrary("fltk_jpeg");
    exe.linkSystemLibrary("fltk_z");
    exe.linkSystemLibrary("c");
    if (target.isWindows()) {
        exe.linkSystemLibrary("ws2_32");
        exe.linkSystemLibrary("comctl32");
        exe.linkSystemLibrary("gdi32");
        exe.linkSystemLibrary("oleaut32");
        exe.linkSystemLibrary("ole32");
        exe.linkSystemLibrary("uuid");
        exe.linkSystemLibrary("shell32");
        exe.linkSystemLibrary("advapi32");
        exe.linkSystemLibrary("comdlg32");
        exe.linkSystemLibrary("winspool");
        exe.linkSystemLibrary("user32");
        exe.linkSystemLibrary("kernel32");
        exe.linkSystemLibrary("odbc32");
    } else if (target.isDarwin()) {
        exe.linkSystemLibrary("Carbon");
        exe.linkSystemLibrary("Cocoa");
        exe.linkSystemLibrary("ApplicationServices");
    } else {
        exe.linkSystemLibrary("pthread");
        exe.linkSystemLibrary("X11");
        exe.linkSystemLibrary("Xext");
        exe.linkSystemLibrary("Xinerama");
        exe.linkSystemLibrary("Xcursor");
        exe.linkSystemLibrary("Xrender");
        exe.linkSystemLibrary("Xfixes");
        exe.linkSystemLibrary("Xft");
        exe.linkSystemLibrary("fontconfig");
        exe.linkSystemLibrary("pango-1.0");
        exe.linkSystemLibrary("pangoxft-1.0");
        exe.linkSystemLibrary("gobject-2.0");
        exe.linkSystemLibrary("cairo");
        exe.linkSystemLibrary("pangocairo-1.0");
    }
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}

pub fn build_cfltk(b: *void) !void {
    
}