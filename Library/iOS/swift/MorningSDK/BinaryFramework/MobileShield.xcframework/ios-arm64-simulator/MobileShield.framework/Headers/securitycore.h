#ifndef SECURITYCOREWRAPPER_H_
#define SECURITYCOREWRAPPER_H_

#if defined(_WIN32) || defined(__WIN32__)
	#define DLL_CALLCONV __stdcall
	#ifdef LIBTEST_EXPORTS
		#define DLL_API __declspec(dllexport)
	#else
		#define DLL_API __declspec(dllimport)
	#endif // LIBTEST_EXPORTS
#else 
	// try the gcc visibility support (see http://gcc.gnu.org/wiki/Visibility)
	#if defined(__GNUC__) && ((__GNUC__ >= 4) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4))
		#ifndef GCC_HASCLASSVISIBILITY
			#define GCC_HASCLASSVISIBILITY
		#endif
	#endif // __GNUC__
	#define DLL_CALLCONV
	#if defined(GCC_HASCLASSVISIBILITY)
		#define DLL_API __attribute__ ((visibility("default")))
	#else
		#define DLL_API
	#endif		
#endif // WIN32 / !WIN32

DLL_API const char *DLL_CALLCONV get_version(void);
DLL_API const char *DLL_CALLCONV get_signature(void);
DLL_API const char *DLL_CALLCONV get_servicedomain(void);
DLL_API const char *DLL_CALLCONV get_obfuscationkey(void);
DLL_API const char *DLL_CALLCONV get_licensekey(void);
DLL_API const char *DLL_CALLCONV get_ecc25519seed(void);
DLL_API const char *DLL_CALLCONV get_aes256key(void);
DLL_API const char *DLL_CALLCONV get_developerlicense(void);
DLL_API const char *DLL_CALLCONV get_tenant(void);

#endif /* SECURITYCOREWRAPPER_H_ */
