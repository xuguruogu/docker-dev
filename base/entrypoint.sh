#!/bin/sh
set -ex

user_id=${USER_ID:-0}
user_name=${USER_NAME:-"root"}

if [[ `cat /etc/passwd | cut -f1 -d':' | grep -w "$user_name" -c` -eq 0 && $user_id -ne 0 ]]; then
    useradd -s /bin/zsh -u $user_id -o -m $user_name
    sed -i 's/^##includedir \/etc\/sudoers.d/#includedir \/etc\/sudoers.d/g' /etc/sudoers; \
    echo "$user_name ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/$user_name

    cp -r -p ~/.oh-my-zsh ~/.zshrc ~/.zprofile /home/$user_name/
    chown $user_name:$user_name -R /home/$user_name/
    chown $user_name:$user_name /data

    exec /usr/local/bin/gosu "$user_name" "$@"
else
    exec "$@"
fi