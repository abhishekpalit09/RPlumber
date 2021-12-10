FROM rocker/rstudio
RUN apt-get update -qq && apt-get install -y \
      libssl-dev \
      libcurl4-gnutls-dev
	  
# Install OpenJDK-11
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless && \
    apt-get clean;	  

MAINTAINER Abhishek Palit
RUN R -e "install.packages('plumber', dependencies=TRUE)"
RUN R -e "install.packages('swagger', dependencies=TRUE)"
RUN R -e "install.packages('h2o', dependencies=TRUE)"

RUN mkdir /data
COPY GBM_model_R_1638497349376_1.zip /data
COPY plumber.R /data
WORKDIR /data

# plumb and run server
EXPOSE 8000
ENTRYPOINT ["R", "-e", \
    "pr <- plumber::plumb('/data/plumber.R'); pr$run(host='0.0.0.0', port=8000)"]