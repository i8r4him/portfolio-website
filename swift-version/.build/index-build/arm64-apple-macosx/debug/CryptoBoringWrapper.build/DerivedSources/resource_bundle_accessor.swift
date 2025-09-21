import Foundation

extension Foundation.Bundle {
    static let module: Bundle = {
        let mainPath = Bundle.main.bundleURL.appendingPathComponent("swift-crypto_CryptoBoringWrapper.bundle").path
        let buildPath = "/Users/i8r4him/Documents/portfolio-website/swift-version/.build/index-build/arm64-apple-macosx/debug/swift-crypto_CryptoBoringWrapper.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle ?? Bundle(path: buildPath) else {
            // Users can write a function called fatalError themselves, we should be resilient against that.
            Swift.fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}