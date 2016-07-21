FROM index.alauda.cn/library/centos:6.6

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

RUN yum makecache
RUN yum install -y  php56w php56w-fpm
RUN yum install -y  nginx


RUN yum install -y  php56w-redis php56w-mysql.x86_64 php56w-mbstring php56w-pear php56w-devel
RUN yum install -y  pcre pcre-devel git wget tar  gcc gcc-c++ autoconf automake python-setuptools.noarch  setuptool.x86_64
#RUN 	yum clean all



WORKDIR /pip
RUN wget --no-check-certificate https://github.com/pypa/pip/archive/1.5.5.tar.gz
RUN tar zvxf 1.5.5.tar.gz && cd pip-1.5.5/ &&  python setup.py install

#RUN yum install -y python-pip && \
###RUN yum clean all && \
RUN pip install supervisor supervisor-stdout
RUN pip install --upgrade setuptools
RUN easy_install  supervisor

# add php yaf ext
WORKDIR /php-yaf
RUN git clone -b php5 https://github.com/laruence/php-yaf /tmp/php-yaf
RUN cd /tmp/php-yaf && \
	phpize && \
	./configure --with-php-config=/usr/bin/php-config && \
	make && make install && \
	echo -e  '\nextension=yaf.so' >> /etc/php.ini && \
	cd / && rm -rf /tmp/php-yaf && cd ~
#WORKDIR /
#RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
#RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm`


RUN yum install -y php56w-pecl-redis  php56w-mcrypt
