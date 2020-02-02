FROM node:10

RUN npm install -g azure-functions-core-tools@3 --unsafe-perm=true --allow-root

# https://realpython.com/intro-to-pyenv/#installation-location
RUN curl https://pyenv.run | bash

RUN echo "export PATH="/root/.pyenv/bin:$PATH"" >> /root/.bashrc 
#&& . /root/.bashrc && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"

RUN export PATH="/root/.pyenv/bin:$PATH" && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"
RUN /root/.pyenv/bin/pyenv install 3.7.4

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

WORKDIR /src

ENTRYPOINT [ "bash" ]