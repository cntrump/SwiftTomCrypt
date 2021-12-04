import XCTest
import TomCrypt

/* These are test keys [see file test.key] that I use to test my import/export against */
var openssl_private_rsa: [UInt8] = [
    0x30, 0x82, 0x02, 0x5e, 0x02, 0x01, 0x00, 0x02, 0x81, 0x81, 0x00, 0xcf, 0x9a, 0xde, 0x64, 0x8a,
    0xda, 0xc8, 0x33, 0x20, 0xa9, 0xd7, 0x83, 0x31, 0x19, 0x54, 0xb2, 0x9a, 0x85, 0xa7, 0xa1, 0xb7,
    0x75, 0x33, 0xb6, 0xa9, 0xac, 0x84, 0x24, 0xb3, 0xde, 0xdb, 0x7d, 0x85, 0x2d, 0x96, 0x65, 0xe5,
    0x3f, 0x72, 0x95, 0x24, 0x9f, 0x28, 0x68, 0xca, 0x4f, 0xdb, 0x44, 0x1c, 0x3e, 0x60, 0x12, 0x8a,
    0xdd, 0x26, 0xa5, 0xeb, 0xff, 0x0b, 0x5e, 0xd4, 0x88, 0x38, 0x49, 0x2a, 0x6e, 0x5b, 0xbf, 0x12,
    0x37, 0x47, 0xbd, 0x05, 0x6b, 0xbc, 0xdb, 0xf3, 0xee, 0xe4, 0x11, 0x8e, 0x41, 0x68, 0x7c, 0x61,
    0x13, 0xd7, 0x42, 0xc8, 0x80, 0xbe, 0x36, 0x8f, 0xdc, 0x08, 0x8b, 0x4f, 0xac, 0xa4, 0xe2, 0x76,
    0x0c, 0xc9, 0x63, 0x6c, 0x49, 0x58, 0x93, 0xed, 0xcc, 0xaa, 0xdc, 0x25, 0x3b, 0x0a, 0x60, 0x3f,
    0x8b, 0x54, 0x3a, 0xc3, 0x4d, 0x31, 0xe7, 0x94, 0xa4, 0x44, 0xfd, 0x02, 0x03, 0x01, 0x00, 0x01,
    0x02, 0x81, 0x81, 0x00, 0xc8, 0x62, 0xb9, 0xea, 0xde, 0x44, 0x53, 0x1d, 0x56, 0x97, 0xd9, 0x97,
    0x9e, 0x1a, 0xcf, 0x30, 0x1e, 0x0a, 0x88, 0x45, 0x86, 0x29, 0x30, 0xa3, 0x4d, 0x9f, 0x61, 0x65,
    0x73, 0xe0, 0xd6, 0x87, 0x8f, 0xb6, 0xf3, 0x06, 0xa3, 0x82, 0xdc, 0x7c, 0xac, 0xfe, 0x9b, 0x28,
    0x9a, 0xae, 0xfd, 0xfb, 0xfe, 0x2f, 0x0e, 0xd8, 0x97, 0x04, 0xe3, 0xbb, 0x1f, 0xd1, 0xec, 0x0d,
    0xba, 0xa3, 0x49, 0x7f, 0x47, 0xac, 0x8a, 0x44, 0x04, 0x7e, 0x86, 0xb7, 0x39, 0x42, 0x3f, 0xad,
    0x1e, 0xb7, 0x0e, 0xa5, 0x51, 0xf4, 0x40, 0x63, 0x1e, 0xfd, 0xbd, 0xea, 0x9f, 0x41, 0x9f, 0xa8,
    0x90, 0x1d, 0x6f, 0x0a, 0x5a, 0x95, 0x13, 0x11, 0x0d, 0x80, 0xaf, 0x5f, 0x64, 0x98, 0x8a, 0x2c,
    0x78, 0x68, 0x65, 0xb0, 0x2b, 0x8b, 0xa2, 0x53, 0x87, 0xca, 0xf1, 0x64, 0x04, 0xab, 0xf2, 0x7b,
    0xdb, 0x83, 0xc8, 0x81, 0x02, 0x41, 0x00, 0xf7, 0xbe, 0x5e, 0x23, 0xc3, 0x32, 0x3f, 0xbf, 0x8b,
    0x8e, 0x3a, 0xee, 0xfc, 0xfc, 0xcb, 0xe5, 0xf7, 0xf1, 0x0b, 0xbc, 0x42, 0x82, 0xae, 0xd5, 0x7a,
    0x3e, 0xca, 0xf7, 0xd5, 0x69, 0x3f, 0x64, 0x25, 0xa2, 0x1f, 0xb7, 0x75, 0x75, 0x05, 0x92, 0x42,
    0xeb, 0xb8, 0xf1, 0xf3, 0x0a, 0x05, 0xe3, 0x94, 0xd1, 0x55, 0x78, 0x35, 0xa0, 0x36, 0xa0, 0x9b,
    0x7c, 0x92, 0x84, 0x6c, 0xdd, 0xdc, 0x4d, 0x02, 0x41, 0x00, 0xd6, 0x86, 0x0e, 0x85, 0x42, 0x0b,
    0x04, 0x08, 0x84, 0x21, 0x60, 0xf0, 0x0e, 0x0d, 0x88, 0xfd, 0x1e, 0x36, 0x10, 0x65, 0x4f, 0x1e,
    0x53, 0xb4, 0x08, 0x72, 0x80, 0x5c, 0x3f, 0x59, 0x66, 0x17, 0xe6, 0x98, 0xf2, 0xe9, 0x6c, 0x7a,
    0x06, 0x4c, 0xac, 0x76, 0x3d, 0xed, 0x8c, 0xa1, 0xce, 0xad, 0x1b, 0xbd, 0xb4, 0x7d, 0x28, 0xbc,
    0xe3, 0x0e, 0x38, 0x8d, 0x99, 0xd8, 0x05, 0xb5, 0xa3, 0x71, 0x02, 0x40, 0x6d, 0xeb, 0xc3, 0x2d,
    0x2e, 0xf0, 0x5e, 0xa4, 0x88, 0x31, 0x05, 0x29, 0x00, 0x8a, 0xd1, 0x95, 0x29, 0x9b, 0x83, 0xcf,
    0x75, 0xdb, 0x31, 0xe3, 0x7a, 0x27, 0xde, 0x3a, 0x74, 0x30, 0x0c, 0x76, 0x4c, 0xd4, 0x50, 0x2a,
    0x40, 0x2d, 0x39, 0xd9, 0x99, 0x63, 0xa9, 0x5d, 0x80, 0xae, 0x53, 0xca, 0x94, 0x3f, 0x05, 0x23,
    0x1e, 0xf8, 0x05, 0x04, 0xe1, 0xb8, 0x35, 0xf2, 0x17, 0xb3, 0xa0, 0x89, 0x02, 0x41, 0x00, 0xab,
    0x90, 0x88, 0xfa, 0x60, 0x08, 0x29, 0x50, 0x9a, 0x43, 0x8b, 0xa0, 0x50, 0xcc, 0xd8, 0x5a, 0xfe,
    0x97, 0x64, 0x63, 0x71, 0x74, 0x22, 0xa3, 0x20, 0x02, 0x5a, 0xcf, 0xeb, 0xc6, 0x16, 0x95, 0x54,
    0xd1, 0xcb, 0xab, 0x8d, 0x1a, 0xc6, 0x00, 0xfa, 0x08, 0x92, 0x9c, 0x71, 0xd5, 0x52, 0x52, 0x35,
    0x96, 0x71, 0x4b, 0x8b, 0x92, 0x0c, 0xd0, 0xe9, 0xbf, 0xad, 0x63, 0x0b, 0xa5, 0xe9, 0xb1, 0x02,
    0x41, 0x00, 0xdc, 0xcc, 0x27, 0xc8, 0xe4, 0xdc, 0x62, 0x48, 0xd5, 0x9b, 0xaf, 0xf5, 0xab, 0x60,
    0xf6, 0x21, 0xfd, 0x53, 0xe2, 0xb7, 0x5d, 0x09, 0xc9, 0x1a, 0xa1, 0x04, 0xa9, 0xfc, 0x61, 0x2c,
    0x5d, 0x04, 0x58, 0x3a, 0x5a, 0x39, 0xf1, 0x4a, 0x21, 0x56, 0x67, 0xfd, 0xcc, 0x20, 0xa3, 0x8f,
    0x78, 0x18, 0x5a, 0x79, 0x3d, 0x2e, 0x8e, 0x7e, 0x86, 0x0a, 0xe6, 0xa8, 0x33, 0xc1, 0x04, 0x17,
    0x4a, 0x9f
]

/*** openssl public RSA key in DER format */
var openssl_public_rsa: [UInt8] = [
    0x30, 0x81, 0x9f, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01,
    0x05, 0x00, 0x03, 0x81, 0x8d, 0x00, 0x30, 0x81, 0x89, 0x02, 0x81, 0x81, 0x00, 0xcf, 0x9a, 0xde,
    0x64, 0x8a, 0xda, 0xc8, 0x33, 0x20, 0xa9, 0xd7, 0x83, 0x31, 0x19, 0x54, 0xb2, 0x9a, 0x85, 0xa7,
    0xa1, 0xb7, 0x75, 0x33, 0xb6, 0xa9, 0xac, 0x84, 0x24, 0xb3, 0xde, 0xdb, 0x7d, 0x85, 0x2d, 0x96,
    0x65, 0xe5, 0x3f, 0x72, 0x95, 0x24, 0x9f, 0x28, 0x68, 0xca, 0x4f, 0xdb, 0x44, 0x1c, 0x3e, 0x60,
    0x12, 0x8a, 0xdd, 0x26, 0xa5, 0xeb, 0xff, 0x0b, 0x5e, 0xd4, 0x88, 0x38, 0x49, 0x2a, 0x6e, 0x5b,
    0xbf, 0x12, 0x37, 0x47, 0xbd, 0x05, 0x6b, 0xbc, 0xdb, 0xf3, 0xee, 0xe4, 0x11, 0x8e, 0x41, 0x68,
    0x7c, 0x61, 0x13, 0xd7, 0x42, 0xc8, 0x80, 0xbe, 0x36, 0x8f, 0xdc, 0x08, 0x8b, 0x4f, 0xac, 0xa4,
    0xe2, 0x76, 0x0c, 0xc9, 0x63, 0x6c, 0x49, 0x58, 0x93, 0xed, 0xcc, 0xaa, 0xdc, 0x25, 0x3b, 0x0a,
    0x60, 0x3f, 0x8b, 0x54, 0x3a, 0xc3, 0x4d, 0x31, 0xe7, 0x94, 0xa4, 0x44, 0xfd, 0x02, 0x03, 0x01,
    0x00, 0x01
]

/* generated with the private key above as:
   echo -n 'test' | openssl rsautl -sign -inkey rsa_private.pem -pkcs -hexdump
 */
var openssl_rsautl_pkcs: [UInt8] = [
    0x24, 0xef, 0x54, 0xea, 0x1a, 0x12, 0x0c, 0xf4, 0x04, 0x0c, 0x48, 0xc8, 0xe8, 0x17, 0xd2, 0x6f,
    0xc3, 0x41, 0xb3, 0x97, 0x5c, 0xbc, 0xa3, 0x2d, 0x21, 0x00, 0x10, 0x0e, 0xbb, 0xf7, 0x30, 0x21,
    0x7e, 0x12, 0xd2, 0xdf, 0x26, 0x28, 0xd8, 0x0f, 0x6d, 0x4d, 0xc8, 0x4d, 0xa8, 0x78, 0xe7, 0x03,
    0xee, 0xbc, 0x68, 0xba, 0x98, 0xea, 0xe9, 0xb6, 0x06, 0x8d, 0x85, 0x5b, 0xdb, 0xa6, 0x49, 0x86,
    0x6f, 0xc7, 0x3d, 0xe0, 0x53, 0x83, 0xe0, 0xea, 0xb1, 0x08, 0x6a, 0x7b, 0xbd, 0xeb, 0xb5, 0x4a,
    0xdd, 0xbc, 0x64, 0x97, 0x8c, 0x17, 0x20, 0xa3, 0x5c, 0xd4, 0xb8, 0x87, 0x43, 0xc5, 0x13, 0xad,
    0x41, 0x6e, 0x45, 0x41, 0x32, 0xd4, 0x09, 0x12, 0x7f, 0xdc, 0x59, 0x1f, 0x28, 0x3f, 0x1e, 0xbc,
    0xef, 0x57, 0x23, 0x4b, 0x3a, 0xa3, 0x24, 0x91, 0x4d, 0xfb, 0xb2, 0xd4, 0xe7, 0x5e, 0x41, 0x7e
]

/* same key but with extra headers stripped */
var openssl_public_rsa_stripped: [UInt8] = [
    0x30, 0x81, 0x89, 0x02, 0x81, 0x81, 0x00, 0xcf, 0x9a, 0xde,
    0x64, 0x8a, 0xda, 0xc8, 0x33, 0x20, 0xa9, 0xd7, 0x83, 0x31, 0x19, 0x54, 0xb2, 0x9a, 0x85, 0xa7,
    0xa1, 0xb7, 0x75, 0x33, 0xb6, 0xa9, 0xac, 0x84, 0x24, 0xb3, 0xde, 0xdb, 0x7d, 0x85, 0x2d, 0x96,
    0x65, 0xe5, 0x3f, 0x72, 0x95, 0x24, 0x9f, 0x28, 0x68, 0xca, 0x4f, 0xdb, 0x44, 0x1c, 0x3e, 0x60,
    0x12, 0x8a, 0xdd, 0x26, 0xa5, 0xeb, 0xff, 0x0b, 0x5e, 0xd4, 0x88, 0x38, 0x49, 0x2a, 0x6e, 0x5b,
    0xbf, 0x12, 0x37, 0x47, 0xbd, 0x05, 0x6b, 0xbc, 0xdb, 0xf3, 0xee, 0xe4, 0x11, 0x8e, 0x41, 0x68,
    0x7c, 0x61, 0x13, 0xd7, 0x42, 0xc8, 0x80, 0xbe, 0x36, 0x8f, 0xdc, 0x08, 0x8b, 0x4f, 0xac, 0xa4,
    0xe2, 0x76, 0x0c, 0xc9, 0x63, 0x6c, 0x49, 0x58, 0x93, 0xed, 0xcc, 0xaa, 0xdc, 0x25, 0x3b, 0x0a,
    0x60, 0x3f, 0x8b, 0x54, 0x3a, 0xc3, 0x4d, 0x31, 0xe7, 0x94, 0xa4, 0x44, 0xfd, 0x02, 0x03, 0x01,
    0x00, 0x01
]

var pkcs8_private_rsa: [UInt8] = [
    0x30, 0x82, 0x02, 0x78, 0x02, 0x01, 0x00, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7,
    0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x04, 0x82, 0x02, 0x62, 0x30, 0x82, 0x02, 0x5e, 0x02, 0x01,
    0x00, 0x02, 0x81, 0x81, 0x00, 0xcf, 0x9a, 0xde, 0x64, 0x8a, 0xda, 0xc8, 0x33, 0x20, 0xa9, 0xd7,
    0x83, 0x31, 0x19, 0x54, 0xb2, 0x9a, 0x85, 0xa7, 0xa1, 0xb7, 0x75, 0x33, 0xb6, 0xa9, 0xac, 0x84,
    0x24, 0xb3, 0xde, 0xdb, 0x7d, 0x85, 0x2d, 0x96, 0x65, 0xe5, 0x3f, 0x72, 0x95, 0x24, 0x9f, 0x28,
    0x68, 0xca, 0x4f, 0xdb, 0x44, 0x1c, 0x3e, 0x60, 0x12, 0x8a, 0xdd, 0x26, 0xa5, 0xeb, 0xff, 0x0b,
    0x5e, 0xd4, 0x88, 0x38, 0x49, 0x2a, 0x6e, 0x5b, 0xbf, 0x12, 0x37, 0x47, 0xbd, 0x05, 0x6b, 0xbc,
    0xdb, 0xf3, 0xee, 0xe4, 0x11, 0x8e, 0x41, 0x68, 0x7c, 0x61, 0x13, 0xd7, 0x42, 0xc8, 0x80, 0xbe,
    0x36, 0x8f, 0xdc, 0x08, 0x8b, 0x4f, 0xac, 0xa4, 0xe2, 0x76, 0x0c, 0xc9, 0x63, 0x6c, 0x49, 0x58,
    0x93, 0xed, 0xcc, 0xaa, 0xdc, 0x25, 0x3b, 0x0a, 0x60, 0x3f, 0x8b, 0x54, 0x3a, 0xc3, 0x4d, 0x31,
    0xe7, 0x94, 0xa4, 0x44, 0xfd, 0x02, 0x03, 0x01, 0x00, 0x01, 0x02, 0x81, 0x81, 0x00, 0xc8, 0x62,
    0xb9, 0xea, 0xde, 0x44, 0x53, 0x1d, 0x56, 0x97, 0xd9, 0x97, 0x9e, 0x1a, 0xcf, 0x30, 0x1e, 0x0a,
    0x88, 0x45, 0x86, 0x29, 0x30, 0xa3, 0x4d, 0x9f, 0x61, 0x65, 0x73, 0xe0, 0xd6, 0x87, 0x8f, 0xb6,
    0xf3, 0x06, 0xa3, 0x82, 0xdc, 0x7c, 0xac, 0xfe, 0x9b, 0x28, 0x9a, 0xae, 0xfd, 0xfb, 0xfe, 0x2f,
    0x0e, 0xd8, 0x97, 0x04, 0xe3, 0xbb, 0x1f, 0xd1, 0xec, 0x0d, 0xba, 0xa3, 0x49, 0x7f, 0x47, 0xac,
    0x8a, 0x44, 0x04, 0x7e, 0x86, 0xb7, 0x39, 0x42, 0x3f, 0xad, 0x1e, 0xb7, 0x0e, 0xa5, 0x51, 0xf4,
    0x40, 0x63, 0x1e, 0xfd, 0xbd, 0xea, 0x9f, 0x41, 0x9f, 0xa8, 0x90, 0x1d, 0x6f, 0x0a, 0x5a, 0x95,
    0x13, 0x11, 0x0d, 0x80, 0xaf, 0x5f, 0x64, 0x98, 0x8a, 0x2c, 0x78, 0x68, 0x65, 0xb0, 0x2b, 0x8b,
    0xa2, 0x53, 0x87, 0xca, 0xf1, 0x64, 0x04, 0xab, 0xf2, 0x7b, 0xdb, 0x83, 0xc8, 0x81, 0x02, 0x41,
    0x00, 0xf7, 0xbe, 0x5e, 0x23, 0xc3, 0x32, 0x3f, 0xbf, 0x8b, 0x8e, 0x3a, 0xee, 0xfc, 0xfc, 0xcb,
    0xe5, 0xf7, 0xf1, 0x0b, 0xbc, 0x42, 0x82, 0xae, 0xd5, 0x7a, 0x3e, 0xca, 0xf7, 0xd5, 0x69, 0x3f,
    0x64, 0x25, 0xa2, 0x1f, 0xb7, 0x75, 0x75, 0x05, 0x92, 0x42, 0xeb, 0xb8, 0xf1, 0xf3, 0x0a, 0x05,
    0xe3, 0x94, 0xd1, 0x55, 0x78, 0x35, 0xa0, 0x36, 0xa0, 0x9b, 0x7c, 0x92, 0x84, 0x6c, 0xdd, 0xdc,
    0x4d, 0x02, 0x41, 0x00, 0xd6, 0x86, 0x0e, 0x85, 0x42, 0x0b, 0x04, 0x08, 0x84, 0x21, 0x60, 0xf0,
    0x0e, 0x0d, 0x88, 0xfd, 0x1e, 0x36, 0x10, 0x65, 0x4f, 0x1e, 0x53, 0xb4, 0x08, 0x72, 0x80, 0x5c,
    0x3f, 0x59, 0x66, 0x17, 0xe6, 0x98, 0xf2, 0xe9, 0x6c, 0x7a, 0x06, 0x4c, 0xac, 0x76, 0x3d, 0xed,
    0x8c, 0xa1, 0xce, 0xad, 0x1b, 0xbd, 0xb4, 0x7d, 0x28, 0xbc, 0xe3, 0x0e, 0x38, 0x8d, 0x99, 0xd8,
    0x05, 0xb5, 0xa3, 0x71, 0x02, 0x40, 0x6d, 0xeb, 0xc3, 0x2d, 0x2e, 0xf0, 0x5e, 0xa4, 0x88, 0x31,
    0x05, 0x29, 0x00, 0x8a, 0xd1, 0x95, 0x29, 0x9b, 0x83, 0xcf, 0x75, 0xdb, 0x31, 0xe3, 0x7a, 0x27,
    0xde, 0x3a, 0x74, 0x30, 0x0c, 0x76, 0x4c, 0xd4, 0x50, 0x2a, 0x40, 0x2d, 0x39, 0xd9, 0x99, 0x63,
    0xa9, 0x5d, 0x80, 0xae, 0x53, 0xca, 0x94, 0x3f, 0x05, 0x23, 0x1e, 0xf8, 0x05, 0x04, 0xe1, 0xb8,
    0x35, 0xf2, 0x17, 0xb3, 0xa0, 0x89, 0x02, 0x41, 0x00, 0xab, 0x90, 0x88, 0xfa, 0x60, 0x08, 0x29,
    0x50, 0x9a, 0x43, 0x8b, 0xa0, 0x50, 0xcc, 0xd8, 0x5a, 0xfe, 0x97, 0x64, 0x63, 0x71, 0x74, 0x22,
    0xa3, 0x20, 0x02, 0x5a, 0xcf, 0xeb, 0xc6, 0x16, 0x95, 0x54, 0xd1, 0xcb, 0xab, 0x8d, 0x1a, 0xc6,
    0x00, 0xfa, 0x08, 0x92, 0x9c, 0x71, 0xd5, 0x52, 0x52, 0x35, 0x96, 0x71, 0x4b, 0x8b, 0x92, 0x0c,
    0xd0, 0xe9, 0xbf, 0xad, 0x63, 0x0b, 0xa5, 0xe9, 0xb1, 0x02, 0x41, 0x00, 0xdc, 0xcc, 0x27, 0xc8,
    0xe4, 0xdc, 0x62, 0x48, 0xd5, 0x9b, 0xaf, 0xf5, 0xab, 0x60, 0xf6, 0x21, 0xfd, 0x53, 0xe2, 0xb7,
    0x5d, 0x09, 0xc9, 0x1a, 0xa1, 0x04, 0xa9, 0xfc, 0x61, 0x2c, 0x5d, 0x04, 0x58, 0x3a, 0x5a, 0x39,
    0xf1, 0x4a, 0x21, 0x56, 0x67, 0xfd, 0xcc, 0x20, 0xa3, 0x8f, 0x78, 0x18, 0x5a, 0x79, 0x3d, 0x2e,
    0x8e, 0x7e, 0x86, 0x0a, 0xe6, 0xa8, 0x33, 0xc1, 0x04, 0x17, 0x4a, 0x9f
]

/* private key - hexadecimal */
let pk_d = 0
let pk_dP = 1
let pk_dQ = 2
let pk_e = 3
let pk_N = 4
let pk_p = 5
let pk_q = 6
let pk_qP = 7

var hex_key: [String] = [
    "C862B9EADE44531D5697D9979E1ACF301E0A8845862930A34D9F616573E0D6878FB6F306A382DC7CACFE9B289AAEFDFBFE2F0ED89704E3BB1FD1EC0DBAA3497F47AC8A44047E86B739423FAD1EB70EA551F440631EFDBDEA9F419FA8901D6F0A5A9513110D80AF5F64988A2C786865B02B8BA25387CAF16404ABF27BDB83C881",
    "6DEBC32D2EF05EA488310529008AD195299B83CF75DB31E37A27DE3A74300C764CD4502A402D39D99963A95D80AE53CA943F05231EF80504E1B835F217B3A089",
    "AB9088FA600829509A438BA050CCD85AFE976463717422A320025ACFEBC6169554D1CBAB8D1AC600FA08929C71D552523596714B8B920CD0E9BFAD630BA5E9B1",
    "010001",
    "CF9ADE648ADAC83320A9D783311954B29A85A7A1B77533B6A9AC8424B3DEDB7D852D9665E53F7295249F2868CA4FDB441C3E60128ADD26A5EBFF0B5ED48838492A6E5BBF123747BD056BBCDBF3EEE4118E41687C6113D742C880BE368FDC088B4FACA4E2760CC9636C495893EDCCAADC253B0A603F8B543AC34D31E794A444FD",
    "F7BE5E23C3323FBF8B8E3AEEFCFCCBE5F7F10BBC4282AED57A3ECAF7D5693F6425A21FB77575059242EBB8F1F30A05E394D1557835A036A09B7C92846CDDDC4D",
    "D6860E85420B0408842160F00E0D88FD1E3610654F1E53B40872805C3F596617E698F2E96C7A064CAC763DED8CA1CEAD1BBDB47D28BCE30E388D99D805B5A371",
    "DCCC27C8E4DC6248D59BAFF5AB60F621FD53E2B75D09C91AA104A9FC612C5D04583A5A39F14A215667FDCC20A38F78185A793D2E8E7E860AE6A833C104174A9F"
]

func register_algs() {
    /* register algs, so they can be printed */
    register_all_ciphers()
    register_all_hashes()
    register_all_prngs()
    
    var mpi: [Int8] = [ 0x4c ]  // 'L'
    crypt_mp_init(&mpi)
}

class TomCryptTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        register_algs()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRSACompat() throws {
        var key = rsa_key()
        var pubkey = rsa_key()

        /* try reading the key */
        XCTAssertEqual(rsa_import(openssl_private_rsa, UInt(openssl_private_rsa.count), &key), Int32(CRYPT_OK))
        XCTAssertEqual(rsa_import(openssl_public_rsa, UInt(openssl_public_rsa.count), &pubkey), Int32(CRYPT_OK))

        var buf = [UInt8](repeating: 0, count: 1024)
        var len = UInt(buf.count)
        XCTAssertEqual(rsa_sign_hash_ex([UInt8]("test".utf8), 4, &buf, &len, Int32(LTC_PKCS_1_V1_5_NA1.rawValue), nil, 0, 0, 0, &key), Int32(CRYPT_OK))
        XCTAssertEqual(len, UInt(openssl_rsautl_pkcs.count))
        XCTAssertEqual(memcmp(openssl_rsautl_pkcs, buf, Int(len)), 0)

        var stat: Int32 = 0
        XCTAssertEqual(rsa_verify_hash_ex(&openssl_rsautl_pkcs, UInt(openssl_rsautl_pkcs.count), [UInt8]("test".utf8), 4, Int32(LTC_PKCS_1_V1_5_NA1.rawValue), 0, 0, &stat, &pubkey), Int32(CRYPT_OK))
        XCTAssertEqual(stat, 1)

        rsa_free(&pubkey)

        len = UInt(buf.count)
        XCTAssertEqual(rsa_export(&buf, &len, Int32(PK_PRIVATE.rawValue), &key), Int32(CRYPT_OK))
        XCTAssertEqual(len, UInt(openssl_private_rsa.count))
        XCTAssertEqual(memcmp(openssl_private_rsa, buf, Int(len)), 0)

        len = UInt(buf.count)
        XCTAssertEqual(rsa_export(&buf, &len, Int32(PK_PUBLIC.rawValue), &key), Int32(CRYPT_OK))
        XCTAssertEqual(len, UInt(openssl_public_rsa_stripped.count))
        XCTAssertEqual(memcmp(openssl_public_rsa_stripped, buf, Int(len)), 0)

        rsa_free(&key)

        /* try reading the public key */
        XCTAssertEqual(rsa_import(openssl_public_rsa_stripped, UInt(openssl_public_rsa_stripped.count), &key), Int32(CRYPT_OK))
        len = UInt(buf.count)
        XCTAssertEqual(rsa_export(&buf, &len, Int32(PK_PUBLIC.rawValue), &key), Int32(CRYPT_OK))
        XCTAssertEqual(len, UInt(openssl_public_rsa_stripped.count))
        XCTAssertEqual(memcmp(openssl_public_rsa_stripped, buf, Int(len)), 0)

        rsa_free(&key)
        
        /* try reading the public key */
        XCTAssertEqual(rsa_import(openssl_public_rsa, UInt(openssl_public_rsa.count), &key), Int32(CRYPT_OK))
        len = UInt(buf.count)
        XCTAssertEqual(rsa_export(&buf, &len, Int32(PK_PUBLIC.rawValue), &key), Int32(CRYPT_OK))
        XCTAssertEqual(len, UInt(openssl_public_rsa_stripped.count))
        XCTAssertEqual(memcmp(openssl_public_rsa_stripped, buf, Int(len)), 0)

        rsa_free(&key)

        /* try import private key in pkcs8 format */
        XCTAssertEqual(rsa_import_pkcs8(pkcs8_private_rsa, UInt(pkcs8_private_rsa.count), nil, 0, &key), Int32(CRYPT_OK))
        len = UInt(buf.count)
        XCTAssertEqual(rsa_export(&buf, &len, Int32(PK_PRIVATE.rawValue), &key), Int32(CRYPT_OK))
        XCTAssertEqual(len, UInt(openssl_private_rsa.count))
        XCTAssertEqual(memcmp(openssl_private_rsa, buf, Int(len)), 0)

        rsa_free(&key)

        /* convert raw hexadecimal numbers to binary */

        let key_buf_len = 128
        var key_parts = [[UInt8]](repeating: [UInt8](repeating: 0, count: key_buf_len), count: 8)
        var key_lens = [UInt](repeating: 0, count: 8)

        for i in 0..<8 {
            let p = hex_key[i].cString(using: .utf8)  // NUL-terminated char buffer
            var q = key_parts[i]
            var len = UInt(q.count)
            XCTAssertEqual(radix_to_bin(p, 16, &q, &len), Int32(CRYPT_OK))
            key_parts[i] = q.dropLast(key_buf_len - Int(len))
            key_lens[i] = len
        }

        /* try import private key from converted raw hexadecimal numbers */
        XCTAssertEqual(rsa_set_key(key_parts[pk_N], key_lens[pk_N], key_parts[pk_e], key_lens[pk_e], key_parts[pk_d], key_lens[pk_d], &key), Int32(CRYPT_OK))
        XCTAssertEqual(rsa_set_factors(key_parts[pk_p], key_lens[pk_p], key_parts[pk_q], key_lens[pk_q], &key), Int32(CRYPT_OK))
        XCTAssertEqual(rsa_set_crt_params(key_parts[pk_dP], key_lens[pk_dP], key_parts[pk_dQ], key_lens[pk_dQ], key_parts[pk_qP], key_lens[pk_qP], &key), Int32(CRYPT_OK))
        len = UInt(buf.count)
        XCTAssertEqual(rsa_export(&buf, &len, Int32(PK_PRIVATE.rawValue), &key), Int32(CRYPT_OK))
        XCTAssertEqual(len, UInt(openssl_private_rsa.count))
        XCTAssertEqual(memcmp(openssl_private_rsa, buf, Int(len)), 0)

        rsa_free(&key)

        /* try import public key from converted raw hexadecimal numbers */
        XCTAssertEqual(rsa_set_key(key_parts[pk_N], key_lens[pk_N], key_parts[pk_e], key_lens[pk_e], nil, 0, &key), Int32(CRYPT_OK))
        len = UInt(buf.count)
        XCTAssertEqual(rsa_export(&buf, &len, Int32(PK_PUBLIC.rawValue), &key), Int32(CRYPT_OK))
        XCTAssertEqual(len, UInt(openssl_public_rsa_stripped.count))
        XCTAssertEqual(memcmp(openssl_public_rsa_stripped, buf, Int(len)), 0)

        rsa_free(&key)

        /* try export in SubjectPublicKeyInfo format of the public key */
        XCTAssertEqual(rsa_import(openssl_public_rsa, UInt(openssl_public_rsa.count), &key), Int32(CRYPT_OK))
        len = UInt(buf.count)
        XCTAssertEqual(rsa_export(&buf, &len, Int32(PK_PUBLIC.rawValue | PK_STD.rawValue), &key), Int32(CRYPT_OK))
        XCTAssertEqual(len, UInt(openssl_public_rsa.count))
        XCTAssertEqual(memcmp(openssl_public_rsa, buf, Int(len)), 0)

        rsa_free(&key)
    }
}