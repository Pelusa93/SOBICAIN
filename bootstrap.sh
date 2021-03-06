#!/usr/bin/env bash
sudo pacman-key --populate archlinux
sudo pacman -Syu
sudo pacman -S --noconfirm docker
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo pacman -S --noconfirm lynx
sudo pacman -S --noconfirm nmap
sudo gpasswd -a vagrant docker
docker rm sobicain_mysql
docker rm sobicain_wp
docker pull wordpress
docker pull mysql:5.7.24
docker run  --name sobicain_mysql \
            -e MYSQL_ROOT_PASSWORD=root \
             -d mysql:5.7
#            -v /vagrant/mysql_data:/var/lib/mysql \

docker run  --name sobicain_wp \
            --link sobicain_mysql:mysql \
             -p 8080:80 \
              -v /vagrant/wp/plugins:/var/www/html/wp-content/plugins \
              -v /vagrant/wp/themes:/var/www/html/wp-content/themes \
              -d wordpress



# running gitlab docker container
# docker run --detach \
#    --hostname gitlab.example.com \
#    --publish 443:443 --publish 80:80 --publish 22:22 \
#    --name gitlab \
#    --restart always \
#    --volume /srv/gitlab/config:/etc/gitlab \
#    --volume /srv/gitlab/logs:/var/log/gitlab \
#    --volume /srv/gitlab/data:/var/opt/gitlab \
#    gitlab/gitlab-ce:latest
