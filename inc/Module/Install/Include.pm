#line 1 "inc/Module/Install/Include.pm - /usr/local/share/perl/5.8.4/Module/Install/Include.pm"
package Module::Install::Include;

use Module::Install::Base;
@ISA = qw(Module::Install::Base);

sub include { +shift->admin->include(@_) };
sub include_deps { +shift->admin->include_deps(@_) };
sub auto_include { +shift->admin->auto_include(@_) };
sub auto_include_deps { +shift->admin->auto_include_deps(@_) };
sub auto_include_dependent_dists { +shift->admin->auto_include_dependent_dists(@_) }
1;