# % --- BEGIN DISCLAIMER ---
# % Those who use this do so at their own risk;
# % AFSEO does not provide maintenance nor support.
# % --- END DISCLAIMER ---
# % --- BEGIN AFSEO_DATA_RIGHTS ---
# % This is a work of the U.S. Government and is placed
# % into the public domain in accordance with 17 USC Sec.
# % 105. Those who redistribute or derive from this work
# % are requested to include a reference to the original,
# % at <https://github.com/afseo/cmits>, for example by
# % including this notice in its entirety in derived works.
# % --- END AFSEO_DATA_RIGHTS ---
class dns::no_mdns_ads::darwin_10_9 {
    $slld = '/System/Library/LaunchDaemons'
# \implements{mlionstig}{OSX8-00-00545}%
# Turn off Bonjour multicast advertising on Macs.
    mac_plist_value { 'add NoMulticastAdvertisements':
        file => "${slld}/com.apple.mDNSResponder.plist",
        key => 'ProgramArguments',
        value => [
            '/usr/sbin/mDNSResponder',
            '-NoMulticastAdvertisements',
            ],
    }
}
