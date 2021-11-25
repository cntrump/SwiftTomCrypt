# SwiftTomCrypt

SwiftPM for [libtomecrypt](https://github.com/libtom/libtomcrypt) & [libtommath](https://github.com/libtom/libtommath)

```swift
dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/cntrump/SwiftTomCrypt.git", .branch("master")),
],
```

## Example

libtomcrypt

```swift
import libtomcrypt

let data = "123".data(using: .utf8)
var md = hash_state()
var hash = [UInt8](repeating: 0, count: 16)
md5_init(&md)

if let data = data {
    md5_process(&md, 
                data.withUnsafeBytes { $0.bindMemory(to: UInt8.self).baseAddress }, 
                UInt(data.count))
}

md5_done(&md, &hash)
```

libtommath

```swift
import libtommath

var a = mp_int()
mp_init(&a)
mp_rand(&a, 16)
```