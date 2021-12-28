FROM alpine:3.8 As build1
 
RUN mkdir /var/flaskapp
    
WORKDIR  /var/flaskapp

RUN  apk update && apk add python3 && apk add git

RUN git clone https://github.com/Jisjo/Docker_python_flask_helow-world.git /var/flaskapp


FROM alpine:3.8 

RUN mkdir /var/flaskapp

WORKDIR  /var/flaskapp

RUN  apk update && apk add python3

COPY --from=build1 /var/flaskapp .

RUN  pip3 install -r requirements.txt

EXPOSE  5000

ENTRYPOINT [ "/usr/bin/python3" ]

CMD [ "app.py" ]
