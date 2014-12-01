Настройка рабочего окружения редактора электронных учебников.
--------------------------------------------------------------

### Необходимое программное обеспечение.
Для настройки рабочего окружения вам понадобится комплекс программного обеспечения LAMP. Что в него должно входить:

* Linux, Ubuntu 12.04 или 14.04
* Веб-сервер Apache или Nginx (здесь подробно описаны настройки для обоих серверов http://symfony.com/doc/current/cookbook/configuration/web_server_configuration.html)
* MySQL сервер версии 5.0 или выше
* PHP версии 5.4 или выше

В данном документе описание настройки выше упомянутого комплекса не будет, подразумевается что вы знакомы с этой технологией и самостоятельно можете произвести все необходимые настройки. В интернете достаточно много статей которые вам в этом помогут http://lmgtfy.com/?q=настройка+LAMP
После того как настройка комплекса LAMP закончена, приступаем к установки проекта. 

### Загрузка исходного кода проекта

Исходный код проекта храниться на открытом сервисе https://github.com/, под контролем версий git.

Для начала установите git на свой сервер.
    apt-get install git

В данном описание будет озвучено такое выражение как «корень проекта» это условное выражение под которым я подразумеваю веб-директорию, для примера это может быть следующий путь /var/www/ebook-editor

Первым делом переходим в корень проекта.
    cd /var/www/ebook-editor

Выписываем проект из репозитория.

    git clone https://github.com/ITAttractor/eTextBookEditor .


### Symfony2

Проект был реализован на основе PHP фрэймворка Symfony2, актуальной стабильной версии на момент написания документа (2.3), для внесения изменений в исходный код вам необходимо ознакомиться с документацией фрэймворка http://symfony.com/doc/current/book/index.html. Фреймворк требует установки библиотек которые не храняться в репозитории. Установка библиотек производится с помощью инструмента Composer.

### Composer

Для того что бы воспользоваться composer, достаточно скачать файл composer.phar с официального сайта инструмента. 
https://getcomposer.org/download/ После чего необходимо выполнить загрузку библиотек. 
Откройте консоль и перейдите в корень проекта, после чего выполните команду.

    php composer.phar update

** Что бы данная команда сработала composer.phar должен лежать в корне проекта. Или же необходимо указать полный путь до composer.phar например:

    php /opt/composer.phar update

После выполнения команды начнется установка необходимых для проекта библиотек. 

### Компиляция js, css файлов

Для компоновки скриптов  и файлов стилей вам понадобиться установить Bower и Grunt.

Bower понадобиться для загрузки js-библиотек. Подробно с этим инструментом можно ознакомиться на официальном сайте http://bower.io/. 
Bower устанавливается как пакет nodejs http://nodejs.org/ Для установки выполняем следующие шаги.

Устанавливаем nodejs:

    sudo apt-get install nodejs

Устанавливаем менеджер пакетов:

    sudo apt-get install npm

Устанавливаем bower:

    npm install bower

Теперь можно получить необходимые js и css компоненты для проекта, из корня проекта выполните команду.

    bower install

js и css файлов в проекте много, для того что бы их было удобно использовать, с помощью grunt мы собираем их в один файл js и один файл css.

Устанавливаем grunt (официальный сайт http://gruntjs.com/):

    npm install grunt

Выполняем сборку, выполните команду из корня проекта:

    grunt full

Теперь у нас есть все необходимые файлы для запуска.

### База данных

Для того что бы подключить базу данных необходимо создать файл app/config/parameters.yml в папке проекта. Ниже представлено содержимое файла:

    database_driver: pdo_mysql
    database_host: 127.0.0.1
    database_port: null
    database_name: ebook
    database_user: root
    database_password: null
    mailer_transport: gmail
    mailer_host: null
    mailer_user: ''
    mailer_password: ''
    locale: ru
    secret: adasd78a7f9asd9a9av7d9sf7fa9800hb0cx0
 
Необходимо указать параметры подключения к базе, имя базы, имя пользователя и пароль.

Следующая команда, создать базу, с указанным названием в файле настройки.

    php app/console doctrine:database:create

После чего выполняем консольные задачи symfony для генерации таблиц в базе.

    php app/console doctrine:schema:update --force 

Завершающим шагом, чистим кэш проекта и выставлям права доступа для кэш папки:

    rm -r app/cache/*
    chmod -R 777 app/cache
    chmod -R 777 app/logs

Теперь можно открыть в браузере указанный вами в настройках веб-сервера адрес, и проверить работоспособность редактора.
