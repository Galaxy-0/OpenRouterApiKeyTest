#!/bin/bash

# OpenRouter API测试脚本

# 颜色设置
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # 无颜色

echo -e "${BLUE}====================================${NC}"
echo -e "${BLUE}   OpenRouter API 连接性测试工具   ${NC}"
echo -e "${BLUE}====================================${NC}"
echo ""

# 检查命令行参数
API_KEY=""
MODEL=""
RUN_TEST=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --api-key=*)
      API_KEY="${1#*=}"
      shift
      ;;
    --model=*)
      MODEL="${1#*=}"
      shift
      ;;
    --test)
      RUN_TEST=true
      shift
      ;;
    --help)
      echo "用法: ./run_test.sh [选项]"
      echo ""
      echo "选项:"
      echo "  --api-key=KEY    设置OpenRouter API密钥"
      echo "  --model=MODEL    设置要测试的模型名称"
      echo "                   默认: nousresearch/deephermes-3-mistral-24b-preview:free"
      echo "  --test           运行单元测试"
      echo "  --help           显示帮助信息"
      echo ""
      echo "免费模型参考:"
      echo "  nousresearch/deephermes-3-mistral-24b-preview:free"
      echo "  palm2:free"
      echo "  mistralai/mistral-7b-instruct:free"
      echo "  google/gemma-7b-it:free"
      exit 0
      ;;
    *)
      echo "未知参数: $1"
      echo "使用 --help 查看帮助"
      exit 1
      ;;
  esac
done

# 构建命令行参数
CMD_ARGS=""

if [ ! -z "$API_KEY" ]; then
  CMD_ARGS="$CMD_ARGS --api-key $API_KEY"
fi

if [ ! -z "$MODEL" ]; then
  CMD_ARGS="$CMD_ARGS --model $MODEL"
fi

if [ "$RUN_TEST" = true ]; then
  CMD_ARGS="$CMD_ARGS --test"
fi

# 运行Python脚本
echo -e "${BLUE}运行命令: python main.py $CMD_ARGS${NC}"
echo ""

python main.py $CMD_ARGS

# 检查退出状态
EXIT_CODE=$?
if [ $EXIT_CODE -eq 0 ]; then
  echo ""
  echo -e "${GREEN}测试完成!${NC}"
else
  echo ""
  echo -e "${RED}测试失败，退出码: $EXIT_CODE${NC}"
fi

exit $EXIT_CODE 