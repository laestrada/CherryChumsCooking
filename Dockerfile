# FROM jekyll/jekyll:stable
# RUN useradd -ms /bin/bash jekyll-user
# RUN chown -R jekyll-user:jekyll-user /usr/gem/
# USER jekyll-user
# WORKDIR /home/jekyll-user
# ENV JEKYLL_ROOTLESS=true
FROM ruby:2-alpine as jekyll

RUN apk add --no-cache build-base gcc bash cmake git
WORKDIR /site
COPY . .

# install both bundler 1.x and 2.x incase you're running
# old gem files
# https://bundler.io/guides/bundler_2_upgrade.html#faq
RUN gem install bundler -v "~>1.0" && gem install bundler jekyll

EXPOSE 4000


RUN bundle install
# RUN bundle exec jekyll serve

# WORKDIR /workspaces/CherryChumsCooking
# ** [Optional] Uncomment this section to install additional packages. **
# RUN apk update \
#     && apk add --no-cache <your-package-list-here>
CMD bundle exec jekyll serve --host 0.0.0.0
# Run with docker run -p 80:4000 <image-name>
