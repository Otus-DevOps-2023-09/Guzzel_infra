# Guzzel_infra
Guzzel Infra repository

!!! HW3 !!!

Данные для подключения:
bastion_IP = 158.160.118.135
someinternalhost_IP = 10.128.0.18

Способ подключения к someinternalhost в одну команду:
ssh -J appuser@158.160.118.135 appuser@10.128.0.18

Способ подключения из консоли по алиасу someinternalhost:
Добавляем настройки в ~/.ssh/config:
Host bastion
  user appuser
  IdentityFile ~/.ssh/appuser
  hostname 158.160.118.135

Host someinternalhost
  IdentityFile ~/.ssh/appuser
  hostname 10.128.0.18
  user appuser
  proxyjump bastion


!!! HW4 !!!

#Устанавливаем YC CLI
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
exec -l $SHELL
yc init

#Используем CLI для создания инстанса
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub

#Устанавливаем Ruby
ssh yc-user@158.160.109.149
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

#Устанавливаем MongoDB
sudo apt update
sudo apt install mongodb -y
Проверяем корректность установки:
systemctl status mongodb
Запускаем MongoDB:
sudo systemctl start mongodb
Добавляем в автозапуск:
sudo systemctl enable mongodb

#Деплой приложения
sudo -i apt-get install git
Копируем код приложения
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d


testapp_IP = 158.160.109.149
testapp_port = 9292
