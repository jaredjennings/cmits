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
# Set the proxy for use in the shell and programs it starts.

class proxy::shell($server, $port) {
    shell::profile_d::sh_entry { 'proxy':
        content => "
export http_proxy=http://${server}:${port}
export https_proxy=http://${server}:${port}
export ftp_proxy=http://${server}:${port}
",
    }
}
