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
# \subsubsection{Disable Red Hat graphical boot}
# This is so that the video driver will certainly not be in use at boot time,
# so we can install the NVIDIA driver if necessary.

class grub::rhgb::no {
    $g = "/boot/grub/grub.conf"
    exec { "disable_rhgb_kernel_cmdlines":
        path => "/bin:/sbin",
        onlyif => "grep '^[[:space:]]*kernel' $g | \
                   grep -v rhgb >&/dev/null",
        command => "sed -i.disable_rhgb -e \
                    '/[[:space:]]*kernel/s/\\<rhgb\\>//' $g",
        logoutput => true,
    }
}
