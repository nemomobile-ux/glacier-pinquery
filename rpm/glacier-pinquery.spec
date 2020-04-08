Name:       glacier-pinquery

Summary:    QML based PIN query application using ofono-qt
Version:    0.3
Release:    1
Group:      Applications/Communications
License:    BSD
URL:        https://github.com/nemomobile-ux/glacier-pinquery
Source0:    %{name}-%{version}.tar.bz2
Requires:   qt5-qtquickcontrols-nemo
Requires:   libglacierapp
Requires:   libqofono-qt5

BuildRequires:  cmake
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5DBus)
BuildRequires:  pkgconfig(qofono-qt5)
BuildRequires:  pkgconfig(glacierapp)

Provides:   meego-pinquery > 0.0.2
Obsoletes:   meego-pinquery <= 0.0.2

%description
QML PIN query dialog

%prep
%setup -q -n %{name}-%{version}

%build
mkdir build
cd build
cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=%{_prefix} \
	-DCMAKE_VERBOSE_MAKEFILE=ON \
	..
cmake --build .

%install
cd build
rm -rf %{buildroot}
DESTDIR=%{buildroot} cmake --build . --target install

%files
%defattr(-,root,root,-)
%{_bindir}/glacier-pinquery
%{_datadir}/glacier-pinquery/qml/
%{_libdir}/systemd/user/glacier-pinquery.service
