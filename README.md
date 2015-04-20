#HuBoard-Pubsub

HuBoard Saas' Faye Pubsub Server. 

### Setup Local

Assuming both vagrant development boxes are using default settings:

  - ``` librarian-puppet install ```

  - ``` vagrant up ```

  - ``` vagrant ssh ```

  - ``` cd /srv/huboard-pubsub ```

  - ``` bundle install ```

  - ``` rbenv rehash ```

  - Run the huboard web server from the other vagrant box with: ```SOCKET_BACKEND=http://192.168.50.12/site/pubsub```

  - Start the Faye server using ```./x.run_local``` from /srv/huboard-pubsub

