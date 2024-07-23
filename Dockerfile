FROM maven:3.9.6-eclipse-temurin-11

# Google Chrome

ARG CHROME_VERSION=126.0.6478.182
RUN apt-get update -qqy \
	&& apt-get -qqy install gpg unzip \
	&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update -qqy \
	&& apt-get -qqy install google-chrome-stable=$CHROME_VERSION \
	&& rm /etc/apt/sources.list.d/google-chrome.list \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
	&& sed -i 's/"$HERE\/chrome"/"$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome
#RUN apt-get -qqy install gpg unzip
#RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
#RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
#RUN apt-get update -qqy
#RUN apt-get -qqy install google-chrome-stable=$CHROME_VERSION
#RUN rm /etc/apt/sources.list.d/google-chrome.list
#RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*
#RUN sed -i 's/"$HERE\/chrome"/"$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome



# ChromeDriver

ARG CHROME_DRIVER_VERSION=126.0.6478.182
RUN wget -q -O /tmp/chromedriver.zip https://storage.googleapis.com/chrome-for-testing-public/$CHROME_DRIVER_VERSION/linux64/chromedriver-linux64.zip \
	&& unzip /tmp/chromedriver.zip -d /opt \
	&& rm /tmp/chromedriver.zip \
	&& ln -s /opt/chromedriver-linux64/chromedriver /usr/bin/chromedriver