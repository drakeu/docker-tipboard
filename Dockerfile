FROM dockerfile/ubuntu

RUN apt-get update
RUN apt-get install -y python-dev python-virtualenv redis-server supervisor

ADD supervisord.conf /etc/supervisor/supervisord.conf

USER root

ADD tipboard /root/.tipboard

RUN mkdir /root/logs

RUN bash -c "cd /root && virtualenv tb-env && source /root/tb-env/bin/activate && pip install tipboard"

EXPOSE 7272

CMD ["/usr/bin/supervisord", "-j", "/root/supervisord.pid"]
