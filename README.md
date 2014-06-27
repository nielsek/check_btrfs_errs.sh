
sudoers:

    $nrpe-user  ALL=NOPASSWD: $path/check_btrfs_errs.sh

nrpe.cfg

    command[check_btrfs]=$path/sudo $path/check_btrfs_errs.sh
