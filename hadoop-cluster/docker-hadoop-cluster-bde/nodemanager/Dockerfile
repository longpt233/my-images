FROM longpt233/hadoop-base:v2

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1


COPY WordCount.jar /opt/hadoop/applications/WordCount.jar
COPY data-sample/* /opt/hadoop/applications/data-sample/


ADD run.sh /run.sh
RUN chmod a+x /run.sh


EXPOSE 8042

CMD ["/run.sh"]
