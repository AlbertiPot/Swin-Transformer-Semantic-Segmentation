#!/usr/bin/env bash

CONFIG=$1
GPUS=$2
PORT=${PORT:-29500}

PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python -m torch.distributed.launch --nproc_per_node=$GPUS --master_port=$PORT \
    $(dirname "$0")/train.py $CONFIG --launcher pytorch ${@:3}

# $1 $2 表示传参数，传第一个，第二个参数
# $0是 执行的文件名
# dirname输出文件名，$0是指当前的文件 ，"$(dirname $0)/.." 指获得当前$0文件所在目录的上一层文件名，分号是路径的分割符
# ${var:-value} var变量名，value是变量值，负号-是缺省值
# ${@:3} 从第三个参数开始传给train.py文件