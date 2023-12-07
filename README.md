# Guzzel_infra
Guzzel Infra repository

HW3

Данные для подключения:
bastion_IP = 158.160.41.170
someinternalhost_IP = 10.128.0.25

Способ подключения к someinternalhost в одну команду:
ssh -J appuser@158.160.41.170 appuser@10.128.0.25

Способ подключения из консоли по алиасу someinternalhost:
Добавляем настройки в ~/.ssh/config:
Host bastion
  user appuser
  IdentityFile ~/.ssh/appuser
  hostname 158.160.41.170

Host someinternalhost
  IdentityFile ~/.ssh/appuser
  hostname 10.128.0.25
  user appuser
  proxyjump bastion

test
test2
test3
test4
