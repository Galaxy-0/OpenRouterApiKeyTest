#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
OpenRouter API测试工具主入口

使用方法：
python main.py [选项]

选项：
  --test        运行测试
  --api-key     设置API密钥（临时，不保存到.env文件）
  --model       设置要测试的模型名称
  --help        显示帮助信息
"""

import os
import sys
import argparse
from src.openrouter_test import main as run_api_test

def parse_args():
    """解析命令行参数"""
    parser = argparse.ArgumentParser(description='OpenRouter API 连接性测试工具')
    parser.add_argument('--test', action='store_true', help='运行测试')
    parser.add_argument('--api-key', type=str, help='OpenRouter API 密钥')
    parser.add_argument('--model', type=str, help='要测试的模型名称')
    
    return parser.parse_args()

def main():
    """主函数"""
    args = parse_args()
    
    # 处理命令行参数中的临时API设置
    if args.api_key:
        os.environ['OPENROUTER_API_KEY'] = args.api_key
        print(f'已设置临时API密钥: {args.api_key[:5]}...')
    
    if args.model:
        os.environ['CLI_MODEL'] = args.model
        print(f'已设置测试模型: {args.model}')
    
    # 运行测试
    if args.test:
        print('正在运行OpenRouter API测试...')
        try:
            # 方法1：使用unittest命令行运行
            import unittest
            # 先导入测试模块确认可以导入
            sys.path.append(os.path.join(os.getcwd(), 'src'))
            from src import test_api
            
            # 构建测试套件并运行
            loader = unittest.TestLoader()
            suite = loader.loadTestsFromModule(test_api)
            runner = unittest.TextTestRunner(verbosity=2)
            result = runner.run(suite)
            return 0 if result.wasSuccessful() else 1
        except Exception as e:
            print(f"运行测试时出错: {e}")
            return 1
    
    # 运行API测试
    exit_code = run_api_test()
    return exit_code

if __name__ == '__main__':
    exit(main())
