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
define sudo::auditable::for_group(
    $run_as='ALL',
    $no_password=true,
) {
    sudo::auditable::for { "%${name}":
        run_as => $run_as,
        no_password => $no_password,
    }
# Remove the file that the older version of this policy put in place,
# if it's there.
    sudo::policy_file { "${name}":
        ensure => absent,
    }
}

