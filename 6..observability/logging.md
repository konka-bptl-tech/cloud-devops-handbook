logs are messages written by developer to understand what the application doing at particular time loggers are help us debug the 
application

FlunetBit = Light weight Log collector[forwarder] , it is a vendor neutral
LogStash = It is a data formatter
           - logs aggregator
           - advance log filtering
        
ElasticSearch = It will stores the log data
Kibana = UI tool for Elastic Search
LogStash = filtering,format the logs before stroing the elastic search
filebeat = light weight log shipper



# ElasticSearch

# LogStash

# Filebeat

# Kibana


# Tasks

1. I need to collect the logs of only particular ns
2. I want format and parse the logs
3. Need to create dashboards for no of hists to the component how many are success and failure
4. I need to create dashboard for each component to look into logs of component
