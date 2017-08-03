### Подготовка к запуску
http://confluence/pages/viewpage.action?pageId=83406878

### Разворачивание Selenium Grid на локальной машине
1. Забираем докеры из проекта http://git/projects/UFR/repos/ufr-stmt-selenium/browse/docker-selenium-master
2. В корне скачанного проекта создать файл docker-compose.yml
3. Вставить в него следующие строки:
```
seleniumhubcuc:
  image: selenium/hub:2.53.1
  container_name: selenium-hub-cucumber
  ports:
    - 4445:4444
firefoxnodecuc:
  image: selenium/node-firefox:2.53.1
  ports:
    - 5900
  links:
    - seleniumhubcuc:hub
  volumes:
    - /dev/shm:/dev/shm

chromenodecuc:
  image: selenium/node-chrome:2.53.1
  ports:
    - 5900
  links:
    - seleniumhubcuc:hub
  volumes:
    - /dev/shm:/dev/shm
```
4. Запустить hub и по одной ноде для хрома и фаерфокса: docker-compose -f docker-compose.yml up -d
5. Масштабировать по необходимости:
    docker-compose scale chromenode=2
    docker-compose scale firefoxnode=2
6. Удалить selenium grid: docker-compose down
    

### Запуск тестов в 1-поточном режиме

```
cucumber -r features 
         -t ${context.cucumber.tags}
         CASH_URL=${context.cucumber.cash.url}
         REMOTE_HUB=${context.cucumber.remoteHub}
 ```
         
### Запуск тестов в многопоточном режиме

```
parallel_cucumber features -n ${context.cucumber.threads} -o 
        "-t ${context.cucumber.tags} 
        CASH_URL=${context.cucumber.cash.url}
        REMOTE_HUB=${context.cucumber.remoteHub}"
```
* context.cucumber.tags - Тэги, определяющие для какого стенда использовать тестовые данные, стенды ALBO. Не более одного из этих тегов должно присутствовать в качестве опции. Если ни один тег не передан, вся конфигурация считается аналогичной передаче @DEV. Окружение для запуска определяют следующие теги: 
    * @DEV
    * @INT
    * @PRELIVE
    * @PROD
* context.cucumber.stmt.url - URL стенда Заказа наличных
    * DEV http://ufr-dev/ufr-cash-order-ui/order/
    * INT https://testjmb.alfabank.ru/cash/order/
* context.cucumber.remoteHub - URL Selenium Grid. Нет значения по умолчанию. Необходима явная передача. Если не передан, используется настройка обычного Selenium
    * http://ufr-test:4445/wd/hub
* context.cucumber.threads - количество потоков