// SHA2.swift
// based on the Vapor/open-crypto project which tries to replicate the CryptoKit framework interface
// written by AdamFowler 2020/01/30
#if canImport(CommonCrypto)

import CommonCrypto

public struct SHA256Digest : ByteDigest {
    public static var byteCount: Int { return Int(CC_SHA256_DIGEST_LENGTH) }
    public var bytes: [UInt8]
}

public struct SHA256: CCHashFunction {
    public typealias Digest = SHA256Digest
    public static var algorithm: CCHmacAlgorithm { return CCHmacAlgorithm(kCCHmacAlgSHA256) }
    var context: CC_SHA256_CTX

    public static func hash(bufferPointer: UnsafeRawBufferPointer) -> Self.Digest {
        var digest: [UInt8] = .init(repeating: 0, count: Digest.byteCount)
        CC_SHA256(bufferPointer.baseAddress, CC_LONG(bufferPointer.count), &digest)
        return .init(bytes: digest)
    }

    public init() {
        context = CC_SHA256_CTX()
        CC_SHA256_Init(&context)
    }
    
    public mutating func update(bufferPointer: UnsafeRawBufferPointer) {
        CC_SHA256_Update(&context, bufferPointer.baseAddress, CC_LONG(bufferPointer.count))
    }
    
    public mutating func finalize() -> Self.Digest {
        var digest: [UInt8] = .init(repeating: 0, count: Digest.byteCount)
        CC_SHA256_Final(&digest, &context)
        return .init(bytes: digest)
    }
}

public struct SHA384Digest : ByteDigest {
    public static var byteCount: Int { return Int(CC_SHA384_DIGEST_LENGTH) }
    public var bytes: [UInt8]
}

public struct SHA384: CCHashFunction {
    public typealias Digest = SHA384Digest
    public static var algorithm: CCHmacAlgorithm { return CCHmacAlgorithm(kCCHmacAlgSHA384) }
    var context: CC_SHA512_CTX

    public static func hash(bufferPointer: UnsafeRawBufferPointer) -> Self.Digest {
        var digest: [UInt8] = .init(repeating: 0, count: Digest.byteCount)
        CC_SHA384(bufferPointer.baseAddress, CC_LONG(bufferPointer.count), &digest)
        return .init(bytes: digest)
    }

    public init() {
        context = CC_SHA512_CTX()
        CC_SHA384_Init(&context)
    }
    
    public mutating func update(bufferPointer: UnsafeRawBufferPointer) {
        CC_SHA384_Update(&context, bufferPointer.baseAddress, CC_LONG(bufferPointer.count))
    }
    
    public mutating func finalize() -> Self.Digest {
        var digest: [UInt8] = .init(repeating: 0, count: Digest.byteCount)
        CC_SHA384_Final(&digest, &context)
        return .init(bytes: digest)
    }
}

public struct SHA512Digest : ByteDigest {
    public static var byteCount: Int { return Int(CC_SHA512_DIGEST_LENGTH) }
    public var bytes: [UInt8]
}

public struct SHA512: CCHashFunction {
    public typealias Digest = SHA512Digest
    public static var algorithm: CCHmacAlgorithm { return CCHmacAlgorithm(kCCHmacAlgSHA512) }
    var context: CC_SHA512_CTX

    public static func hash(bufferPointer: UnsafeRawBufferPointer) -> Self.Digest {
        var digest: [UInt8] = .init(repeating: 0, count: Digest.byteCount)
        CC_SHA512(bufferPointer.baseAddress, CC_LONG(bufferPointer.count), &digest)
        return .init(bytes: digest)
    }

    public init() {
        context = CC_SHA512_CTX()
        CC_SHA512_Init(&context)
    }
    
    public mutating func update(bufferPointer: UnsafeRawBufferPointer) {
        CC_SHA512_Update(&context, bufferPointer.baseAddress, CC_LONG(bufferPointer.count))
    }
    
    public mutating func finalize() -> Self.Digest {
        var digest: [UInt8] = .init(repeating: 0, count: Digest.byteCount)
        CC_SHA512_Final(&digest, &context)
        return .init(bytes: digest)
    }
}

#else

import CAWSCrypto

public struct SHA256Digest : ByteDigest {
    public static var byteCount: Int { return Int(SHA256_DIGEST_LENGTH) }
    public var bytes: [UInt8]
}

public struct SHA256: _OpenSSLHashFunction {
    public typealias Digest = SHA256Digest
    public static var algorithm: OpaquePointer { return EVP_sha256() }
    var context: OpaquePointer
}

public struct SHA384Digest : ByteDigest {
    public static var byteCount: Int { return Int(SHA384_DIGEST_LENGTH) }
    public var bytes: [UInt8]
}

public struct SHA384: _OpenSSLHashFunction {
    public typealias Digest = SHA384Digest
    public static var algorithm: OpaquePointer { return EVP_sha384() }
    var context: OpaquePointer
}

public struct SHA512Digest : ByteDigest {
    public static var byteCount: Int { return Int(SHA512_DIGEST_LENGTH) }
    public var bytes: [UInt8]
}

public struct SHA512: _OpenSSLHashFunction {
    public typealias Digest = SHA512Digest
    public static var algorithm: OpaquePointer { return EVP_sha512() }
    var context: OpaquePointer
}

#endif
