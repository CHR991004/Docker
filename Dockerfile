# 使用ubuntu作为基础镜像
FROM ubuntu:22.04

# 更新系统并安装wget
RUN apt-get update && apt-get install -y wget

# 下载并安装Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p $HOME/miniconda && \
    rm ~/miniconda.sh && \
    echo 'export PATH="$HOME/miniconda/bin:$PATH"' >> ~/.bashrc

# 创建conda环境并安装所需的软件
RUN /root/miniconda/bin/conda create -y -n rnaseq python=3.6

# 在.bashrc中添加命令以在启动bash shell时自动激活rnaseq环境
RUN echo "source activate rnaseq" >> ~/.bashrc

# 安装所需的软件
RUN /bin/bash -c "source $HOME/miniconda/bin/activate rnaseq && \
    conda install -c bioconda fastqc star rsem snakemake"
