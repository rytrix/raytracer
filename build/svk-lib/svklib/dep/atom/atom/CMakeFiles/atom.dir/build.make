# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ryan/Documents/raytracer

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ryan/Documents/raytracer/build

# Include any dependencies generated for this target.
include svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/compiler_depend.make

# Include the progress variables for this target.
include svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/progress.make

# Include the compile flags for this target's objects.
include svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/flags.make

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/flags.make
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.cxx
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ryan/Documents/raytracer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -x c++-header -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -MD -MT svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch -MF CMakeFiles/atom.dir/cmake_pch.hxx.gch.d -o CMakeFiles/atom.dir/cmake_pch.hxx.gch -c /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.cxx

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/atom.dir/cmake_pch.hxx.i"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -x c++-header -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -E /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.cxx > CMakeFiles/atom.dir/cmake_pch.hxx.i

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/atom.dir/cmake_pch.hxx.s"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -x c++-header -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -S /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.cxx -o CMakeFiles/atom.dir/cmake_pch.hxx.s

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/flags.make
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.o: ../svk-lib/svklib/dep/atom/atom/semaphore.cpp
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ryan/Documents/raytracer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.o"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -MD -MT svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.o -MF CMakeFiles/atom.dir/semaphore.cpp.o.d -o CMakeFiles/atom.dir/semaphore.cpp.o -c /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom/semaphore.cpp

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/atom.dir/semaphore.cpp.i"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -E /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom/semaphore.cpp > CMakeFiles/atom.dir/semaphore.cpp.i

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/atom.dir/semaphore.cpp.s"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -S /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom/semaphore.cpp -o CMakeFiles/atom.dir/semaphore.cpp.s

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/flags.make
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.o: ../svk-lib/svklib/dep/atom/atom/fence.cpp
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ryan/Documents/raytracer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.o"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -MD -MT svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.o -MF CMakeFiles/atom.dir/fence.cpp.o.d -o CMakeFiles/atom.dir/fence.cpp.o -c /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom/fence.cpp

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/atom.dir/fence.cpp.i"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -E /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom/fence.cpp > CMakeFiles/atom.dir/fence.cpp.i

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/atom.dir/fence.cpp.s"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -S /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom/fence.cpp -o CMakeFiles/atom.dir/fence.cpp.s

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/flags.make
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.o: ../svk-lib/svklib/dep/atom/atom/threadpool.cpp
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.o: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ryan/Documents/raytracer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.o"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -MD -MT svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.o -MF CMakeFiles/atom.dir/threadpool.cpp.o.d -o CMakeFiles/atom.dir/threadpool.cpp.o -c /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom/threadpool.cpp

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/atom.dir/threadpool.cpp.i"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -E /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom/threadpool.cpp > CMakeFiles/atom.dir/threadpool.cpp.i

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/atom.dir/threadpool.cpp.s"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Winvalid-pch -include /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx -S /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom/threadpool.cpp -o CMakeFiles/atom.dir/threadpool.cpp.s

# Object files for target atom
atom_OBJECTS = \
"CMakeFiles/atom.dir/semaphore.cpp.o" \
"CMakeFiles/atom.dir/fence.cpp.o" \
"CMakeFiles/atom.dir/threadpool.cpp.o"

# External object files for target atom
atom_EXTERNAL_OBJECTS =

svk-lib/svklib/dep/atom/atom/libatom.a: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/cmake_pch.hxx.gch
svk-lib/svklib/dep/atom/atom/libatom.a: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/semaphore.cpp.o
svk-lib/svklib/dep/atom/atom/libatom.a: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/fence.cpp.o
svk-lib/svklib/dep/atom/atom/libatom.a: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/threadpool.cpp.o
svk-lib/svklib/dep/atom/atom/libatom.a: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/build.make
svk-lib/svklib/dep/atom/atom/libatom.a: svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ryan/Documents/raytracer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX static library libatom.a"
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && $(CMAKE_COMMAND) -P CMakeFiles/atom.dir/cmake_clean_target.cmake
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/atom.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/build: svk-lib/svklib/dep/atom/atom/libatom.a
.PHONY : svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/build

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/clean:
	cd /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom && $(CMAKE_COMMAND) -P CMakeFiles/atom.dir/cmake_clean.cmake
.PHONY : svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/clean

svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/depend:
	cd /home/ryan/Documents/raytracer/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ryan/Documents/raytracer /home/ryan/Documents/raytracer/svk-lib/svklib/dep/atom/atom /home/ryan/Documents/raytracer/build /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom /home/ryan/Documents/raytracer/build/svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : svk-lib/svklib/dep/atom/atom/CMakeFiles/atom.dir/depend

