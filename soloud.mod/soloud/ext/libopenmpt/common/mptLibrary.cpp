/*
 * mptLibrary.cpp
 * --------------
 * Purpose: Shared library handling.
 * Notes  : (currently none)
 * Authors: OpenMPT Devs
 * The OpenMPT source code is released under the BSD license. Read LICENSE for more details.
 */


#include "stdafx.h"
#include "mptLibrary.h"

#if defined(MPT_WITH_DYNBIND)
#if MPT_OS_WINDOWS
#include <windows.h>
#elif MPT_OS_ANDROID
#include <dlfcn.h>
#else
#include <ltdl.h>
#endif
#endif


OPENMPT_NAMESPACE_BEGIN


#if defined(MPT_WITH_DYNBIND)


namespace mpt
{


#if MPT_OS_WINDOWS


// KB2533623 / Win8
#ifndef LOAD_LIBRARY_SEARCH_DEFAULT_DIRS
#define LOAD_LIBRARY_SEARCH_DEFAULT_DIRS    0x00001000
#endif
#ifndef LOAD_LIBRARY_SEARCH_APPLICATION_DIR
#define LOAD_LIBRARY_SEARCH_APPLICATION_DIR 0x00000200
#endif
#ifndef LOAD_LIBRARY_SEARCH_SYSTEM32
#define LOAD_LIBRARY_SEARCH_SYSTEM32        0x00000800
#endif
#ifndef LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR
#define LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR    0x00000100
#endif


mpt::PathString GetAppPath()
{
#if defined(MODPLUG_TRACKER)
	std::vector<WCHAR> exeFileName(MAX_PATH);
	while(GetModuleFileNameW(0, &exeFileName[0], exeFileName.size()) >= exeFileName.size())
	{
		exeFileName.resize(exeFileName.size() * 2);
	}
	return mpt::GetAbsolutePath(mpt::PathString::FromNative(&exeFileName[0]).GetPath());
#else
	return mpt::PathString(); // dummy
#endif
}


mpt::PathString GetSystemPath()
{
	DWORD size = GetSystemDirectoryW(nullptr, 0);
	std::vector<WCHAR> path(size + 1);
	if(!GetSystemDirectoryW(&path[0], size + 1))
	{
		return mpt::PathString();
	}
	return mpt::PathString::FromNative(&path[0]) + MPT_PATHSTRING("\\");
}


class LibraryHandle
{

private:

	HMODULE hModule;

public:

	LibraryHandle(const mpt::LibraryPath &path)
		: hModule(NULL)
	{

		// Check for KB2533623:
		bool hasKB2533623 = false;
		if(mpt::Windows::Version::IsAtLeast(mpt::Windows::Version::Win8))
		{
			hasKB2533623 = true;
		} else if(mpt::Windows::Version::IsAtLeast(mpt::Windows::Version::WinVista))
		{
			HMODULE hKernel32DLL = LoadLibraryW(L"kernel32.dll");
			if(hKernel32DLL)
			{
				if(::GetProcAddress(hKernel32DLL, "SetDefaultDllDirectories") != nullptr)
				{
					hasKB2533623 = true;
				}
				FreeLibrary(hKernel32DLL);
				hKernel32DLL = NULL;
			}
		}

		if(hasKB2533623)
		{
			switch(path.GetSearchPath())
			{
				case mpt::LibrarySearchPathDefault:
					hModule = LoadLibraryExW(path.GetFileName().AsNative().c_str(), NULL, LOAD_LIBRARY_SEARCH_DEFAULT_DIRS);
					break;
				case mpt::LibrarySearchPathSystem:
					hModule = LoadLibraryExW(path.GetFileName().AsNative().c_str(), NULL, LOAD_LIBRARY_SEARCH_SYSTEM32);
					break;
#if 0
					// Using restricted search paths applies to potential DLL dependencies
					// recursively.
					// This fails loading for e.g. Codec or Plugin DLLs in application
					// directory if they depend on the MSVC C or C++ runtime (which is
					// located in the system directory).
					// Just rely on the default search path here.
				case mpt::LibrarySearchPathApplication:
					hModule = LoadLibraryExW(path.GetFileName().AsNative().c_str(), NULL, LOAD_LIBRARY_SEARCH_APPLICATION_DIR);
					break;
				case mpt::LibrarySearchPathFullPath:
					hModule = LoadLibraryExW(path.GetFileName().AsNative().c_str(), NULL, LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR);
					break;
#else
				case mpt::LibrarySearchPathApplication:
					hModule = LoadLibraryW((mpt::GetAppPath() + path.GetFileName()).AsNative().c_str());
					break;
				case mpt::LibrarySearchPathFullPath:
					hModule = LoadLibraryW(path.GetFileName().AsNative().c_str());
					break;
#endif
			}
		} else
		{
			switch(path.GetSearchPath())
			{
				case mpt::LibrarySearchPathDefault:
					hModule = LoadLibraryW(path.GetFileName().AsNative().c_str());
					break;
				case mpt::LibrarySearchPathApplication:
					hModule = LoadLibraryW((mpt::GetAppPath() + path.GetFileName()).AsNative().c_str());
					break;
				case mpt::LibrarySearchPathSystem:
					hModule = LoadLibraryW((mpt::GetSystemPath() + path.GetFileName()).AsNative().c_str());
					break;
				case mpt::LibrarySearchPathFullPath:
					hModule = LoadLibraryW(path.GetFileName().AsNative().c_str());
					break;
			}
		}
	}

	~LibraryHandle()
	{
		if(IsValid())
		{
			FreeLibrary(hModule);
		}
		hModule = NULL;
	}

public:

	bool IsValid() const
	{
		return (hModule != NULL);
	}

	FuncPtr GetProcAddress(const std::string &symbol) const
	{
		if(!IsValid())
		{
			return nullptr;
		}
		return reinterpret_cast<FuncPtr>(::GetProcAddress(hModule, symbol.c_str()));
	}

};


#elif MPT_OS_ANDROID


// Fake implementation.
// Load shared objects from the JAVA side of things.
class LibraryHandle
{

public:

	LibraryHandle(const mpt::LibraryPath &path)
	{
		return;
	}

	~LibraryHandle()
	{
		return;
	}

public:

	bool IsValid() const
	{
		return true;
	}

	FuncPtr GetProcAddress(const std::string &symbol) const
	{
		if(!IsValid())
		{
			return nullptr;
		}
		return reinterpret_cast<FuncPtr>(dlsym(0, symbol.c_str()));
	}

};



#else // MPT_OS


class LibraryHandle
{

private:

	bool inited;
	lt_dlhandle handle;

public:

	LibraryHandle(const mpt::LibraryPath &path)
		: inited(false)
		, handle(0)
	{
		if(lt_dlinit() != 0)
		{
			return;
		}
		inited = true;
		handle = lt_dlopenext(path.GetFileName().AsNative().c_str());
	}

	~LibraryHandle()
	{
		if(IsValid())
		{
			lt_dlclose(handle);
		}
		handle = 0;
		if(inited)
		{
			lt_dlexit();
			inited = false;
		}
	}

public:

	bool IsValid() const
	{
		return handle != 0;
	}

	FuncPtr GetProcAddress(const std::string &symbol) const
	{
		if(!IsValid())
		{
			return nullptr;
		}
		return reinterpret_cast<FuncPtr>(lt_dlsym(handle, symbol.c_str()));
	}

};


#endif // MPT_OS


LibraryPath::LibraryPath(mpt::LibrarySearchPath searchPath, class mpt::PathString const &fileName)
//------------------------------------------------------------------------------------------------
	: searchPath(searchPath)
	, fileName(fileName)
{
	return;
}


mpt::LibrarySearchPath LibraryPath::GetSearchPath() const
//-------------------------------------------------------
{
	return searchPath;
}


mpt::PathString LibraryPath::GetFileName() const
//----------------------------------------------
{
	return fileName;
}


mpt::PathString LibraryPath::GetDefaultPrefix()
//---------------------------------------------
{
	#if MPT_OS_WINDOWS
		return MPT_PATHSTRING("");
	#else
		return MPT_PATHSTRING("lib");
	#endif
}


mpt::PathString LibraryPath::GetDefaultSuffix()
//---------------------------------------------
{
	#if MPT_OS_WINDOWS
		return MPT_PATHSTRING(".dll");
	#else
		return MPT_PATHSTRING("");  // handled by libltdl
	#endif
}


LibraryPath LibraryPath::App(const mpt::PathString &basename)
//-----------------------------------------------------------
{
	return LibraryPath(mpt::LibrarySearchPathApplication, GetDefaultPrefix() + basename + GetDefaultSuffix());
}


LibraryPath LibraryPath::AppFullName(const mpt::PathString &fullname)
//-------------------------------------------------------------------
{
	return LibraryPath(mpt::LibrarySearchPathApplication, fullname + GetDefaultSuffix());
}


LibraryPath LibraryPath::System(const mpt::PathString &basename)
//--------------------------------------------------------------
{
	return LibraryPath(mpt::LibrarySearchPathSystem, GetDefaultPrefix() + basename + GetDefaultSuffix());
}


LibraryPath LibraryPath::FullPath(const mpt::PathString &path)
//------------------------------------------------------------
{
	return LibraryPath(mpt::LibrarySearchPathFullPath, path);
}


Library::Library()
//----------------
{
	return;
}


Library::Library(const mpt::LibraryPath &path)
//--------------------------------------------
{
	m_Handle = mpt::make_shared<LibraryHandle>(path);
}


void Library::Unload()
//--------------------
{
	*this = mpt::Library();
}


bool Library::IsValid() const
//---------------------------
{
	return m_Handle && m_Handle->IsValid();
}


FuncPtr Library::GetProcAddress(const std::string &symbol) const
//--------------------------------------------------------------
{
	if(!IsValid())
	{
		return nullptr;
	}
	return m_Handle->GetProcAddress(symbol);
}


} // namespace mpt


#endif // MPT_WITH_DYNBIND


OPENMPT_NAMESPACE_END
