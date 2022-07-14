FROM rocker/r-ver:4.0.4

RUN apt-get update 

RUN apt-get install -y \
    build-essential wget unzip curl \
    python3.8 python3.8-dev python3-pip \
    python-is-python3 python3-matplotlib \
    libicu-dev libssl-dev libffi-dev libxml2-dev \
    libxslt1-dev zlib1g-dev libreadline-dev \
    liblzma-dev libbz2-dev zlib1g libpng-dev \
    gfortran-7 libglpk-dev libhdf5-dev libcurl4-openssl-dev

RUN pip3 install scanpy numpy pandas umap-learn leidenalg igraph anndata regex sbmltoodepy matplotlib networkx 

RUN Rscript -e 'install.packages(c("remotes", "BiocManager", "R.utils"))' && \
    Rscript -e 'BiocManager::install()'

RUN Rscript -e 'BiocManager::install(c("impute", "preprocessCore", "GO.db", "AnnotationDbi"))'

RUN Rscript -e "install.packages(c('data.table','matrixStats', 'checkmate', 'htmlTable', 'Hmisc', 'WGCNA', 'Seurat'))"

RUN Rscript -e "remotes::install_github('satijalab/seurat-data')"

RUN Rscript -e "install.packages('SeuratObject')"

RUN Rscript -e "remotes::install_github('mojaveazure/seurat-disk')"

ENTRYPOINT ["bash"]
