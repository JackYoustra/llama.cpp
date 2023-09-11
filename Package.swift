// swift-tools-version:5.8

import PackageDescription

let commonFlags = [
    "-fno-coverage-mapping",
    "-fno-profile-instr-generate",
    "-fno-objc-arc",
]

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
            sources: ["ggml.c", "llama.cpp", "ggml-metal.m", "k_quants.c", "examples/common.cpp"],
            resources: [
                .process("ggml-metal.metal"),
            ],
            publicHeadersPath: "spm-headers",
            cSettings: [
                .unsafeFlags(["-Wno-shorten-64-to-32"]),
                .define("GGML_USE_ACCELERATE"),
                .define("GGML_USE_METAL"),
                .define("GGML_METAL_NDEBUG"),
                .define("GGML_USE_K_QUANTS"),
                .unsafeFlags(commonFlags),
            ],
            cxxSettings: [
                .unsafeFlags(commonFlags),
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
