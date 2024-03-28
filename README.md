# MorningSDK v1.1.0

## Introduction

As hacking techniques in mobile apps continue to evolve, cases of apps being hacked using the latest technologies have emerged in the app market. Institutions or companies providing services to customers need measures to protect personal information from these sophisticated hacking tools. The MorningSDK mobile library includes features to prevent the execution of apps that require protection of sensitive information by checking for the installation of well-known hacking tools such as Frida, Magisk, Magisk Hide, and FlyJB worldwide. It also has features to prevent attempts at debugging or memory intrusion using some hacking software. Therefore, it includes tools not only to block well-known hacking tools but also to block new hacking tools. Additionally, when sensitive information (user IDs, resident registration numbers, phone numbers) is included in the source code, it includes a feature to obfuscate it, making it difficult to extract the information from apps that have already been distributed. Furthermore, the multimedia SDK provides a library for creating WebRTC applications. It includes support for the latest secure communication technology, QUIC/HTTP3.0, providing enhanced security features compared to existing mVoIP security technologies such as SRTP and ZRTP. It also includes technologies to prevent vulnerabilities in data leakage during voice/video data transmission and to provide improved performance.

## Usage

After including the module files of this library in Android Studio or xCode and calling the library initialization function, the hacking tool blocking feature will be activated.
