#import <Foundation/Foundation.h>
#include "securitycore.h"

@interface SecurityCoreWrapper : NSObject

- (void)getVersion:(NSString *)data;
- (NSString *)getSignature;
- (NSString *)getServiceDomain;
- (NSString *)getObfuscationKey;
- (NSString *)getLicenseKey;
- (NSString *)getAES256Key;
- (NSString *)getDeveloperLicense;
- (NSString *)getTenant;
@end
