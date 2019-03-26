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
%qmake5 
make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
%qmake5_install
mkdir -p %{buildroot}%{_libdir}/systemd/user/

%files
%defattr(-,root,root,-)
%{_bindir}/glacier-pinquery
%{_datadir}/glacier-pinquery/qml/
%{_libdir}/systemd/user/glacier-pinquery.service
