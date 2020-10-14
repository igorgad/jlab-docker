FROM tensorflow/tensorflow:2.3.0-gpu-jupyter

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get update && \
    apt-get install --no-install-recommends -y -q \
	libsm6 \
	libxext6 \
	libxrender-dev \
	unzip \
	wget \
	git \
	fontconfig-config \
	fonts-dejavu-core \
	libcairo2 \
	libfontconfig1 \
	libjbig0 \
	liblcms2-2 \
	libnspr4 \
	libnss3 \
	libpixman-1-0 \
	libpoppler73 \
	libtiff5 \
	libxcb-render0 \
	libxcb-shm0 \
	poppler-data \
	poppler-utils \
	ucf \
	nodejs \
	htop \
	vim

COPY ./requirements.txt .
RUN pip3 install --upgrade pip wheel
RUN pip3 install -U --upgrade-strategy only-if-needed --ignore-installed --no-cache-dir -r requirements.txt
RUN pip3 install jupyterlab jupyter-lsp python-language-server[all] jupyter_http_over_ws jupyterlab_code_formatter black jupyterthemes && \
	  	 jupyter serverextension enable --py jupyter_http_over_ws && \
		 jupyter serverextension enable --py jupyterlab_code_formatter && \
                 jupyter labextension install @krassowski/jupyterlab-lsp && \
		 jupyter labextension install @jupyterlab/toc && \
		 jupyter labextension install @ijmbarr/jupyterlab_spellchecker && \
		 jupyter labextension install @aquirdturtle/collapsible_headings && \
		 jupyter labextension install @ryantam626/jupyterlab_code_formatter

ENV SHELL /bin/bash
WORKDIR /workspace
CMD jupyter-notebook \
	--NotebookApp.allow_origin='https://colab.research.google.com' \
	--NotebookApp.token=p4ss \
	--port=8888 \
	--NotebookApp.port_retries=0 \	
	--ip 0.0.0.0 \
	--no-browser \
	--allow-root


