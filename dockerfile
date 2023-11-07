# # FROM pycaret/full:latest
# FROM pycaret/full:latest
# # COPY ./entrypoint.sh /root/entrypoint.sh
# # RUN chown jovyan /root/entrypoint.sh
# # USER jovyan
# # RUN mkdir /home/jovyan/workspace
# # RUN chown -R jovyan /home/jovyan/workspace
# # WORKDIR /home/jovyan/workspace
# # RUN jupyter notebook --generate-config
# USER root
# # RUN usermod -aG root jovyan
# RUN usermod -u 1000 jovyan
# RUN groupmod -g 1000 users
# USER jovyan


# author Fahad Akbar (fahadakbar@gmail.com)
# Choose image
FROM jupyter/base-notebook:latest

USER root
# name your environment and choose python 3.x version
ARG conda_env=pycaret_full
ARG py_ver=3.8
RUN apt-get update && apt-get install -y git

# add additional libraries you want with mamba 
RUN mamba create --quiet --yes -p "${CONDA_DIR}/envs/${conda_env}" python=${py_ver} ipython ipykernel && \
    mamba clean --all -f -y


# create Python 3.x environment and link it to jupyter
RUN "${CONDA_DIR}/envs/${conda_env}/bin/python" -m ipykernel install --user --name="${conda_env}" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# install pycaret full version
# RUN "${CONDA_DIR}/envs/${conda_env}/bin/pip" install pycaret[full]==3.1.0
RUN "${CONDA_DIR}/envs/${conda_env}/bin/pip" install git+https://github.com/pycaret/pycaret.git@master --upgrade
RUN "${CONDA_DIR}/envs/${conda_env}/bin/pip" install explainerdashboard
# prepend conda environment to path
ENV PATH "${CONDA_DIR}/envs/${conda_env}/bin:${PATH}"

# make the env default
ENV CONDA_DEFAULT_ENV ${conda_env}