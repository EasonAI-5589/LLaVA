# LLaVA最速传说

# 配置LLaVA
我们使用的是Autodl来配置LLaVA，如果出现网络连接问题导致git无法使用，请加速

```bash
source /etc/network_turbo
```
克隆仓库
```bash
git clone https://github.com/EasonAI-5589/LLaVA
cd LLaVA
```
创建python环境

```bash
conda create -n llava python=3.10 -y
# reset terminal
source ~/.bashrc
conda init bash
```
在完成环境创建过后，关闭当前终端，并新建终端，进行下一步

```bash
# activate llava
conda activate llava
```

安装相关依赖

```bash
cd LLaVA
pip install --upgrade pip
pip install -e .
pip install protobuf==3.20.3
```


# 拉取权重模型
安装git-lfs工具用于拉取权重文件
```bash
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
git lfs pull
git lfs install
```

注意预留磁盘空间，建议autodl至少扩容200G
```bash
git lfs install

# 使用hf镜像源拉取不同的权重模型
git clone https://hf-mirror.com/liuhaotian/llava-v1.5-7b

git clone https://hf-mirror.com/liuhaotian/llava-v1.5-13b

git clone https://hf-mirror.com/liuhaotian/llava-v1.6-vicuna-7b

git clone https://hf-mirror.com/liuhaotian/llava-v1.6-vicuna-13b
```

# 配置Benchmark
下载EasonAI开源版，然后按照eval中的benchmark继续操作
```bash
git clone https://github.com/EasonAI-5589/eval.git
```

# 运行示例
首次运行的时候，使用huggingface镜像源替换掉原始huggingface, 用于拉取CLIP权重
```bash
export HF_ENDPOINT=https://hf-mirror.com
```
随后进行图文对话
```bash
python -m llava.serve.cli \
    --model-path /root/autodl-tmp/llava-v1.5-7b \
    --image-file /root/autodl-tmp/LLaVA/images/llava_logo.png\
    --load-4bit
```

test
下载数据集并且修改文件路径

# 运行Evaluation
首次运行的时候，使用huggingface镜像源替换掉原始huggingface, 用于拉取CLIP权重
```bash
export HF_ENDPOINT=https://hf-mirror.com
```

运行eval脚本

```bash

cd /root/autodl-tmp/LLaVA

python -m llava.eval.model_vqa_loader \
    --model-path /root/autodl-tmp/llava-v1.5-7b \
    --question-file /root/autodl-tmp/eval/MME/llava_mme_test.jsonl \
    --image-folder /root/autodl-tmp/eval/MME/MME_Benchmark_release_version \
    --answers-file /root/autodl-tmp/eval/MME/answers/llava-v1.5-7b.jsonl \
    --temperature 0 \
    --conv-mode vicuna_v1


cd /root/autodl-tmp/eval/MME

python convert_answer_to_mme.py --experiment llava-v1.5-7b

cd eval_tool

python calculation.py --results_dir answers/llava-v1.5-7b

cd /root/autodl-tmp/LLaVA
```
