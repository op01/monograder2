FROM perl:5.24
WORKDIR /codecute
ADD cpanfile /codecute
RUN cpanm --installdeps -n .
ENTRYPOINT ["perl","main.pl","prefork"]
