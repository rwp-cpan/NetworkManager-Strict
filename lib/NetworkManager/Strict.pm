# ABSTRACT: NetworkManager strict settings class

use v5.37.9;
use experimental qw( class builtin try );
use feature 'class';

package NetworkManager::Strict;

class NetworkManager::Strict {
  use Path::Tiny qw();
  use System::Command;
  field $path = Path::Tiny -> new( '/etc/NetworkManager/system-connections/' );
  field $ethernet = 'Wired connection 1';
  my %dns = (
    OpenDNS    => [ '208.67.222.123' , '208.67.220.123' ] ,
    CloudFlare => ['1.1.1.3', '1.0.0.3'],
  );

=head1 DESCRIPTION

=head2 DNS

=head3 OpenDNS

https://www.opendns.com/setupguide/#familyshield

=head3 CloudFlare

https://blog.cloudflare.com/introducing-1-1-1-1-for-families/

=cut

  method path ( ) { $path; }
  method ethernet ( ) { $ethernet; }
  method lock ( $profile = $ethernet ) {
    my $file = $path -> child( join '.' , $profile , 'nmconnection' );
    $file -> chmod( 'a-w' );
    # Default permissions: -rw------- 1 root root
  }
  method set_dns ( $profile = $ethernet , $provider = $dns{OpenDNS} ) {
    my $command = System::Command -> new( # Debug with: env SYSTEM_COMMAND_TRACE=3
      'nmcli' , 'connection' ,
      'modify' , $profile ,
      'ipv4.dns' , join( ',' , $provider -> @* )
    );
    # say $command -> stderr -> getlines;

    # Generates:
    # [ipv4]
    # dns=208.67.222.123;208.67.220.123;
  }
}
