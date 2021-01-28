cmake_minimum_required(VERSION 3.6.0)

project(glacier-pinquery
	VERSION 0.3
	DESCRIPTION "QML based PIN query application using ofono-qt")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(FindPkgConfig)
include(FeatureSummary)
include(GNUInstallDirs)

set(QT_MIN_VERSION "5.6.0")
find_package(Qt5 COMPONENTS Gui Qml Quick DBus REQUIRED)
find_package(Glacier COMPONENTS App REQUIRED)

find_package(PkgConfig REQUIRED)
pkg_check_modules(QOFONO qofono-qt5 IMPORTED_TARGET)
pkg_check_modules(SYSTEMD libsystemd)

add_subdirectory(src)

if(QOFONO_FOUND)
	set_property(GLOBAL APPEND PROPERTY PACKAGES_FOUND qofono-qt5)
else()
	set_property(GLOBAL APPEND PROPERTY PACKAGES_NOT_FOUND qofono-qt5)
endif()
if(SYSTEMD_FOUND)
	set_property(GLOBAL APPEND PROPERTY PACKAGES_FOUND libsystemd)
	install(FILES glacier-pinquery.service
		DESTINATION ${CMAKE_INSTALL_LIBDIR}/systemd/user)
else()
	set_property(GLOBAL APPEND PROPERTY PACKAGES_NOT_FOUND libsystemd)
endif()


feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
