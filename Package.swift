// swift-tools-version:5.9

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
            sources: ["ggml.c", "llama.cpp", "ggml-metal.m", "k_quants.c", "examples/common.cpp"],
            publicHeadersPath: "spm-headers",
            cSettings: [
                .unsafeFlags(["-Wno-shorten-64-to-32"]),
                .define("GGML_USE_ACCELERATE"),
                .define("GGML_USE_METAL"),
                .define("GGML_METAL_NDEBUG"),
                .define("GGML_USE_K_QUANTS"),
                .unsafeFlags(["-fno-objc-arc"]),
            ],
            cxxSettings: [
                .unsafeFlags(["-fno-objc-arc"]),
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
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
