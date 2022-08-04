set(SRC
	main.cpp
	ofonosimif.cpp
	ofonosimif.h)

qtquick_compiler_add_resources(RESOURCES qml/glacier-pinquery.qrc)

add_executable(glacier-pinquery ${SRC} ${RESOURCES})

target_link_libraries(glacier-pinquery PUBLIC
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
	Qt5::DBus
	Glacier::App
	PkgConfig::QOFONO)
install(TARGETS glacier-pinquery RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
