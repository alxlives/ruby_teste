Introduction
===================

This tutorial assumes that you have the following environment installed and configured:

- Ruby 2.2.4;
- rails 4.2.6;
- sqlite3;
- bundler 1.11.2;
- Local web server (such as Apache)

If any of them are ruby gems missing, you may want to reinstall the Ruby environment and then, run the command that install the newest version of Rails:

```
gem install rails
```
-----------


The app consists of two parts, "back" and "front":

- The back part is the ruby REST application itself, that receives the requests and answer them with json data. 
- The front is a .js file and a .html example for integration.


Install Steps
===================

1) Download the project from gitHub

2) Open the terminal or command prompt, go to the project "back" folder and run the command:

bundle install

3) run the command acording your operational system:

- Linux / Mac OS: 

```
bin/rails server
```
- Windows:

```
ruby bin/rails server
```

4) open the browser and access the server running path (default http://localhost:3000). If it shows a "Home Index!" message, your server is running.

5) copy the front folder into your local server;

6) open the index.html file on your local server (ex: http://localhost/front/index.html)

6) enter a name and an email. If the popup messages "login feito com sucesso" (login success) and "acesso salvo" (access saved) shows up, the environment is working.

7) enter on your server running page /contatos (http://localhost:3000/acessos). It will show you the last 50 recorded entries on a desc order.

How it works
===================

The backend has two main services:

- /contatosCreate -> receive both "nome" (name) and "email" vars, record the user on the database and then return its id. If the email already exist, it returns the previous recorded user.

- /acessosCreate -> receive the user id ("contato_id") and the page name, records the access and then return its id.

The Javascript receive the login information send to the Ruby backend and receive a response. If there is alredy an user with the same email, it will return the previous user.

Then the Javascript send an access requisition to the server with the current page title and the user ID, so it can record the user access.

Customization
===================

The rails_tracker.js file (inside front/js folder) can be embeded by any html file. To use it as a stand-alone file, follow the steps below:

1) copy it to your project;

2) embed jquery in the html file header:

```
<script  src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
```

3) embed the rails_tracker.js file in the header;

```
<script type='text/javascript' src='js/rails_tracker.js'></script>
```

4) open the rails_tracker.js file (/js) and configure the following vars:

```
var base_url = "http://localhost:3000";
```
- The server running path (default http://localhost:3000)

```
- var txt_name = default document.getElementById("nome");
```
- The path for the HTML "Name" field (default document.getElementById("nome"))

```
var txt_email = default document.getElementById("email");
```
- The path for the HTML "Email" field (default document.getElementById("email"))

```
var btn_login = $("#btLogin");
```
- The path for the Login Button (default $("#btLogin"));

```
var btn_logoff = $("#btLogoff");
```
- The path for the Logoff Button (default $("#btLogoff"));


Performance
===================

The following performance test shows how long it took to process 1000 contact creation requisitions and 1000 access creations requisitions:

```

.ContatosTest#test_creation (953 ms warmup)
           wall_time: 3.79 sec
              memory: 0 Bytes
.ContatosTest#test_get (0 ms warmup)
           wall_time: 3 ms
              memory: 0 Bytes
.AcessosTest#test_creation (1.10 sec warmup)
           wall_time: 3.52 sec
              memory: 0 Bytes
.AcessosTest#test_get (0 ms warmup)
           wall_time: 0 ms
              memory: 0 Bytes
.

Finished in 19.462041s, 0.2569 runs/s, 0.0000 assertions/s.

5 runs, 0 assertions, 0 failures, 0 errors, 0 skips
```