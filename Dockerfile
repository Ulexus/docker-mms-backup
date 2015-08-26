FROM ubuntu:trusty

RUN apt-get update && apt-get install -y curl logrotate

# Get latest from https://mms.mongodb.com/settings/backup-agent
RUN curl -sSL https://cloud.mongodb.com/download/agent/backup/mongodb-mms-backup-agent_3.7.0.304-1_amd64.deb -o mms.deb
RUN dpkg -i mms.deb
RUN rm mms.deb

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

USER mongodb-mms-agent
CMD ["mongodb-mms-backup-agent","-c","/etc/mongodb-mms/backup-agent.config"]
