#import <substrate.h>
#import <Security/Security.h>

extern "C" {

  bool SOSCCSetUserCredentials (CFStringRef user_label,
				CFDataRef user_password,
				CFErrorRef* error);

  bool SOSCCTryUserCredentials(CFStringRef user_label,
			       CFDataRef user_password,
			       CFErrorRef* error);

  bool (*s_orig_creds) (CFStringRef user_label,
			CFDataRef user_password,
			CFErrorRef* error);

  bool my_creds (CFStringRef user_label, CFDataRef user_password, CFErrorRef* error)
  {
    NSLog(@"THIS WORKED");
    return s_orig_creds(user_label, user_password, error);
  }
}

%hook NSMutableURLRequest
-(id)init
{
  NSLog(@"GAR GAR GAR");
  return %orig;
}

%end
%ctor {
  MSHookFunction(SOSCCSetUserCredentials, my_creds, &s_orig_creds);
 }

