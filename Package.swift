// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "llama",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
    ],
    products: [
        .library(name: "llama", targets: ["llama"]),
    ],
    targets: [
        .target(
            name: "llama",
            path: ".",
            exclude: ["ggml-metal.metal"],
            sources: ["ggml.c", "llama.cpp", "ggml-metal.m", "examples/common.cpp"],
            publicHeadersPath: "spm-headers",
            cSettings: [
                .unsafeFlags(["-Wno-shorten-64-to-32"]),
                .define("GGML_USE_ACCELERATE"),
                .define("GGML_USE_METAL"),
                .define("GGML_METAL_NDEBUG"),
                .unsafeFlags(["-fno-objc-arc"]),
                .headerSearchPath("./"),
                .headerSearchPath("include/"),
            ],
            cxxSettings: [
                .unsafeFlags(["-fno-objc-arc"]),
                .headerSearchPath("./"),
                .headerSearchPath("include/"),
            ],
            linkerSettings: [
                .linkedFramework("Accelerate"),
                .linkedFramework("Foundation"),
                .linkedFramework("MetalKit"),
                .linkedFramework("MetalPerformanceShaders"),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx11
)
