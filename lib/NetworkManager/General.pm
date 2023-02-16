# PODNAME: General.pm
# ABSTRACT: NetworkManager properties general class

use v5.37.9;
use experimental qw( class builtin try );

package NetworkManager::General;
class NetworkManager::General {

  use Path::Tiny qw();

  field $path = Path::Tiny -> new( '/etc/NetworkManager/system-connections/' );
  # Configuration directory path

  field $ethernet = 'Wired connection 1';
  # Network interface profile name

  field $extension = 'nmconnection';
  # Network interface profile file extension

  method path ( ) { $path; }

=attr path()

Returns NetworkManager configuration directory path

=cut

  method ethernet ( ) { $ethernet; }

=attr ethernet()

Returns NetworkManager Ethernet interface profile name

This is set as I<Wired connection 1>

=cut

  method extension ( ) { $extension; }

=attr extension()

Returns NetworkManager profile file extension

This is set as I<nmconnection>

=cut

}
