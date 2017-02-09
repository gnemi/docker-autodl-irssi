FROM gnemi/irssi:alpine

USER root

RUN apk add --no-cache --virtual .build-deps \
    git

RUN apk --no-cache add \
    bash \
    perl-archive-zip \
    perl-digest-sha1 \
    perl-html-parser \
    perl-json \
    perl-net-ssleay \
    perl-xml-libxml

RUN mkdir $HOME/.irssi/scripts
RUN git clone --recursive https://github.com/autodl-community/autodl-irssi.git $HOME/.irssi/scripts
RUN mkdir $HOME/.irssi/scripts/autorun
RUN ln -s $HOME/.irssi/scripts/autodl-irssi.pl $HOME/.irssi/scripts/autorun/
RUN mkdir $HOME/.autodl
RUN touch ~/.autodl/autodl.cfg
RUN echo 'load perl' > $HOME/.irssi/startup
RUN chown -R user:user $HOME

RUN apk del .build-deps && rm -rf /tmp/*

USER user
WORKDIR $HOME
VOLUME $HOME/.autodl
VOLUME $HOME/.irssi

CMD ["irssi"]
