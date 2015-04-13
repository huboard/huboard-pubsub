#HuBoard-Pubsub

HuBoard Saas' Faye Pubsub Server. 

### Setup Local

Assuming both vagrant development boxes are using default settings:

  - Add these lines to /etc/hosts 
    ``` 192.168.50.10 huboard.rails ```
    ``` 192.168.50.12 huboard.pubsub ```

  - Run the rails server with ```SOCKET_BACKEND=http://192.168.50.12/site/pubsub```

  - Start the Faye server using ```./x.run\_local```

