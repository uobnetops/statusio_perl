%define debug_package %{nil}

Summary:        perl libraries for interacting with the status.io api
Name:           perl-statusio
Version:        0.0.01
Release:        0
Group:          Applications/System
License:        GPL 3.0
BuildArch:      noarch
Requires:       perl
Source:         %{name}-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-buildroot

%description
perl libraries for interacting with the status.io api

%prep
%setup -n statusio_perl-%{name}-%{version}

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p %{buildroot}%{_usr}/share/perl5/vendor_perl/
rm .gitignore README.md perl-statusio.spec
cp -R * %{buildroot}%{_usr}/share/perl5/vendor_perl/
chmod -R 775 %{buildroot}%{_usr}/share/perl5/vendor_perl/

%clean
rm -rf $RPM_BUILD_ROOT

%post

%files
%defattr(-,root,root,-)
%{_usr}/share/perl5/vendor_perl/

%changelog
* Tue Jan 24 2017 Paul Seward <paul.seward@bristol.ac.uk> - 0.0.01-0
- initial package

