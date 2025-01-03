add_rules("mode.debug", "mode.release")

set_languages("c++17")

target("yuangine")
    set_kind("binary")
    add_files("src/*.cpp")
    add_files("src/modules/*.cpp")
    add_files("src/operations/*.cpp")
    add_files("kernel/*.cpp")
    add_includedirs("$(projectdir)/include")
    add_includedirs("$(projectdir)/include/modules")
    add_includedirs("$(projectdir)/include/operations")
    add_includedirs("$(projectdir)/params")
    add_includedirs("$(projectdir)/kernel/")
    add_links("pthread")
    
--linear层乘法实现方式
-- 0 最原始的实现
-- 1 循环展开
-- 2 多线程
-- 3 simd
-- 4 使用多线程+simd+循环展开加速
    add_defines("IMP=4")

    if is_arch("x86_64", "i386") then
        add_defines("QM_x86")
        add_cxxflags("-mavx2", "-mfma")
    elseif is_arch("arm64", "arm") then
        add_defines("QM_ARM")
        add_cxflags("-mfpu=neon")
    end
--
-- If you want to known more usage about xmake, please see https://xmake.io
--
-- ## FAQ
--
-- You can enter the project directory firstly before building project.
--
--   $ cd projectdir
--
-- 1. How to build project?
--
--   $ xmake
--
-- 2. How to configure project?
--
--   $ xmake f -p [macosx|linux|iphoneos ..] -a [x86_64|i386|arm64 ..] -m [debug|release]
--
-- 3. Where is the build output directory?
--
--   The default output directory is `./build` and you can configure the output directory.
--
--   $ xmake f -o outputdir
--   $ xmake
--
-- 4. How to run and debug target after building project?
--
--   $ xmake run [targetname]
--   $ xmake run -d [targetname]
--
-- 5. How to install target to the system directory or other output directory?
--
--   $ xmake install
--   $ xmake install -o installdir
--
-- 6. Add some frequently-used compilation flags in xmake.lua
--
-- @code
--    -- add debug and release modes
--    add_rules("mode.debug", "mode.release")
--
--    -- add macro definition
--    add_defines("NDEBUG", "_GNU_SOURCE=1")
--
--    -- set warning all as error
--    set_warnings("all", "error")
--
--    -- set language: c99, c++11
--    set_languages("c99", "c++11")
--
--    -- set optimization: none, faster, fastest, smallest
--    set_optimize("fastest")
--
--    -- add include search directories
--    add_includedirs("/usr/include", "/usr/local/include")
--
--    -- add link libraries and search directories
--    add_links("tbox")
--    add_linkdirs("/usr/local/lib", "/usr/lib")
--
--    -- add system link libraries
--    add_syslinks("z", "pthread")
--
--    -- add compilation and link flags
--    add_cxflags("-stdnolib", "-fno-strict-aliasing")
--    add_ldflags("-L/usr/local/lib", "-lpthread", {force = true})
--
-- @endcode
--

