set(SRC
	main.cpp
	ofonosimif.cpp
	ofonosimif.h)

add_executable(glacier-pinquery ${SRC})

target_link_libraries(glacier-pinquery PUBLIC
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
	Qt5::DBus
	Glacier::App
	PkgConfig::QOFONO)
install(TARGETS glacier-pinquery RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-pinquery)
