# Guzzel_infra
Guzzel Infra repository

HW3

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
