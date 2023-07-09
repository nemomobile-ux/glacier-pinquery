set(SRC
	main.cpp
	ofonosimif.cpp
	ofonosimif.h)

qt_add_resources(RESOURCES qml/glacier-pinquery.qrc)

add_executable(glacier-pinquery ${SRC} ${RESOURCES})

target_link_libraries(glacier-pinquery PUBLIC
	Qt6::Gui
	Qt6::Qml
	Qt6::Quick
	Qt6::DBus
	Glacier::App
	PkgConfig::QOFONO)
install(TARGETS glacier-pinquery RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
