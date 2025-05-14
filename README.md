# OpenRouterApiKeyTest
测试多个api供应商服务是否可用

## 项目说明
这个项目用于测试OpenRouter API的连接性，检查API密钥是否有效，并返回API调用的详细信息。

## 安装

### Python版本
```bash
# 安装依赖
pip install -r requirements.txt

# 如果使用uv安装依赖（使用清华镜像源）
uv pip install --index-url https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt
```

### JavaScript版本（已弃用）
```bash
# 使用npm安装依赖
npm install
```

## 配置
1. 在项目根目录创建一个`.env`文件
2. 在`.env`文件中添加以下内容：

```
# OpenRouter API Key
OPENROUTER_API_KEY=your_api_key_here

# OpenRouter API URL (可选)
OPENROUTER_API_URL=https://openrouter.ai/api/v1/chat/completions

# OpenRouter模型 (可选)
OPENROUTER_MODEL=nousresearch/deephermes-3-mistral-24b-preview:free
```

3. 将`your_api_key_here`替换为您的实际OpenRouter API密钥

## 支持的免费模型
测试工具支持以下免费模型（无需支付费用）：
- `nousresearch/deephermes-3-mistral-24b-preview:free` (默认)
- `palm2:free`
- `mistralai/mistral-7b-instruct:free`
- `google/gemma-7b-it:free`

## 使用方法

### 使用Shell脚本（推荐）
项目提供了一个便捷的Shell脚本，支持彩色输出和简化的参数语法：

```bash
# 给脚本添加执行权限（如果尚未添加）
chmod +x run_test.sh

# 使用API密钥运行测试
./run_test.sh --api-key=your_api_key_here

# 指定要测试的模型
./run_test.sh --api-key=your_api_key_here --model=palm2:free

# 运行单元测试
./run_test.sh --test

# 显示帮助信息
./run_test.sh --help
```

### 使用Python命令行
```bash
# 运行测试
python main.py

# 使用临时API密钥
python main.py --api-key your_api_key_here

# 指定要测试的模型
python main.py --model palm2:free

# 运行单元测试
python main.py --test

# 显示帮助信息
python main.py --help
```

### 直接使用Python模块
```bash
# 运行API测试
python src/openrouter_test.py

# 运行单元测试
python src/test_api.py
```

### JavaScript版本（已弃用）
```bash
# 运行测试
npm start
```

## 测试结果说明
程序将显示以下信息：
- API连接状态（成功/失败）
- 响应时间
- 模型信息
- Token使用情况
- API响应内容

## 更新日志

### v1.4.0 (2023-06-02)
- 添加了指定模型参数的功能
- 默认使用免费模型进行测试
- 简化了URL参数，集中在模型选择上

### v1.3.0 (2023-06-01)
- 修复了测试模块导入问题
- 添加了便捷的Shell脚本
- 改进了错误处理

### v1.2.0 (2023-05-30)
- 修复URL路径处理，确保正确连接到OpenRouter API
- 添加命令行参数支持，可临时设置API密钥和URL
- 完善单元测试，增加URL修正测试

### v1.1.0 (2023-05-29)
- 添加Python版本实现
- 创建单元测试
- 废弃JavaScript版本

### v1.0.0 (2023-05-28)
- 初始版本
- 支持测试OpenRouter API连接
- 显示API响应详情和统计信息
