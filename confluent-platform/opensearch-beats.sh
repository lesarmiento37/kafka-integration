input {
    beats {
        port => 5044
    }
}
output {
    elasticsearch {
        hosts => ["https://search-leonardo-domain-sy56melevowdtr26z56dbs3jpq.us-east-1.es.amazonaws.com:9200"]
        user => "leonardo"
        password => "Leonardo37*"
        index => "logstash-index"
    }
}


CLOUD_ID=search-leonardo-domain-sy56melevowdtr26z56dbs3jpq.us-east-1.es.amazonaws.com
CLOUD_AUTH=leonardo:Leonardo37*
sudo filebeat export config -E cloud.id=${CLOUD_ID} -E cloud.auth=${CLOUD_AUTH} > /etc/filebeat/filebeat.yml
sudo metricbeat export config -E cloud.id=${CLOUD_ID} -E cloud.auth=${CLOUD_AUTH} > /etc/metricbeat/metricbeat.yml

ssl:
  certificate_authorities: ["/home/ec2-user/leonardo/AmazonRootCA1.pem"]

  curl -X GET "search-leonardo-domain-sy56melevowdtr26z56dbs3jpq.us-east-1.es.amazonaws.com:9200/" -u leonardo:Leonardo37*
