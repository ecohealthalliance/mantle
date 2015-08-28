#Docker image that closely resembles CircleCI containers
#https://circleci.com/docs/environment

FROM ubuntu:12.04
MAINTAINER EHA Tech Team

#Install apt dependencies
RUN apt-get update && apt-get -y install sudo wget curl gnupg2 git make gcc g++ xvfb firefox bzip2

#Install Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
dpkg -i google-chrome-stable_current_amd64.deb; \
apt-get -yf install

#Install Oracle Java
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections; echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get -y install python-software-properties && \
add-apt-repository ppa:webupd8team/java && \
apt-get update && \
apt-get -y install oracle-java8-installer

#Setup ubuntu user with sudo rights
RUN sed -i 's/ ALL$/ NOPASSWD:ALL/' /etc/sudoers
RUN useradd -m ubuntu && echo "ubuntu:ubuntu" | chpasswd && adduser ubuntu sudo

#From here everything is done as ubuntu user, and not root
USER ubuntu

#Install nvm and nodejs
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash
RUN sudo su -c  'echo "source /home/ubuntu/.nvm/nvm.sh" >> /etc/profile'
RUN . /home/ubuntu/.bashrc && nvm install v0.10.40 && nvm alias default v0.10.40

#Install meteor
RUN curl https://install.meteor.com/ | sh

#Copy relavant repo files over
RUN mkdir -p /home/ubuntu/repo/.meteor/
ADD continuous-integration.sh /home/ubuntu/repo/
ADD .meteor/p* /home/ubuntu/repo/.meteor/
ADD .meteor/release /home/ubuntu/repo/.meteor/
ADD .meteor/versions /home/ubuntu/repo/.meteor/
ADD packages /home/ubuntu/repo/packages/
ADD tests /home/ubuntu/repo/tests/
ADD run-inside-docker.sh  /home/ubuntu/repo/

#Create similar environment variables as found on docker environment
ENV CIRCLECI=true
ENV CI=true
ENV DISPLAY=:99
ENV CIRCLE_BRANCH=fake_branch
ENV CIRCLE_SHA1=123456
ENV CIRCLE_BUILD_NUM=1
ENV CIRCLE_PROJECT_USERNAME=fake_github_user
ENV CIRCLE_PROJECT_REPONAME=github.not/real/repo
ENV CIRCLE_USERNAME=fake_docker_user

CMD /home/ubuntu/repo/run-inside-docker.sh

