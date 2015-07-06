FROM registry

RUN apt-get -y update && apt-get -y install libffi-dev libssl-dev
RUN pip install docker-registry-driver-azureblob

##etcdctl set /services/registry/AZURE_STORAGE_ACCOUNT_NAME youraccountname
##etcdctl set /services/registry/AZURE_STORAGE_ACCOUNT_KEY youraccountkey
##etcdctl set /services/registry/AZURE_STORAGE_CONTAINER storagecontainername

#ADD https://github.com/upfluence/etcdenv/releases/download/v0.2.0/etcdenv-linux-amd64-0.2.0 /usr/local/bin/etcdenv
#RUN chmod a+x /usr/local/bin/etcdenv

#CMD etcdenv -n /services/registry -b exit docker-registry